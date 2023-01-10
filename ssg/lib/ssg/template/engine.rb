# frozen_string_literal: true

module SSG
  class Template
    # An ERB implementation inspired by Erubi.
    #
    # Supported:
    # - Liquid-style whitespace control:
    #   - <%- -%> for stripping all whitespace
    #   - <%_ _%> for slurping all whitespace up to, but not including, a newline
    #
    # - Capturing using the syntax from Rails but with the implementation from Erubi::CaptureEndEngine:
    #   - <%= content_tag(:div) do %>
    #       Hello!
    #     <% end %>
    #
    # Not supported:
    # - Comments:
    #   - <%# this is a comment %>
    #
    # - Escaping:
    #   - <%== "<p>this is escaped</p>" %>
    #
    # I created this engine for two reasons:
    # 1. I wanted more fine-grained control over whitespace, which no ERB implementation seems to get right.
    # 2. I wanted to understand how Erubi worked.
    #
    # For the most part things behave as expected, but the big difference from Rails is in how capturing works.
    # Specifically, this doesn't work:
    #
    # <% x = capture do %>
    #   This would be captured in Rails
    # <% end %>
    #
    # <%= x %>
    #
    # Rails implements capturing at the ActionView::Base level by swapping around the @output_buffer variable that ERB
    # appends strings to. The buffer variable used in this engine is internal to the compiled output, there is no
    # explicit mechanism that allows shuffling it around.
    #
    # I tend not to use capturing anyway, but it's something to be aware of when using any of ActionView's helpers
    # since many of them are depdendent on an explicit #capture method.
    class Engine
      using(Module.new do
        refine String do
          # @return [Boolean]
          def blank?
            empty? || BLANK_REGEXP.match?(self)
          end
        end

        refine StringScanner do
          # UTF-8 compatible version of #pos=
          # @param [Integer] n
          def charpos=(n)
            self.pos = string[...n].bytesize
          end

          # UTF-8 compatible version of #matched_size
          # @return [Integer]
          def matched_charsize
            matched.length
          end
        end
      end)

      BLANK_REGEXP = /\A\s*\z/

      DEFAULT_REGEXP = /<%(=)?(-|_)?(.*?)(-|_)?%>/m

      BLOCK_START_REGEXP = /\s*((\s+|\))do|\{)(\s*\|[^|]*\|)?\s*\Z/
      BLOCK_END_REGEXP = /\s+(end|\}).*?\s+\Z/

      MODE_STRIP = "-"
      MODE_SLURP = "_"

      class << self
        # @return [String]
        def render(...)
          new(...).send(:render)
        end

        private :new
      end

      # @param [String] input
      def initialize(input)
        self.input = StringScanner.new(input)
        self.output = +""

        self.stack = []

        self.buffer_var = "__buffer"
        self.buffers_var = "__buffers"

        self.buffer_val = "String.new"
      end

      private

      attr_accessor :input, :output, :stack, :buffer_var, :buffers_var, :buffer_val

      def render
        output << "#{buffer_var} = #{buffer_val}\n"

        p_pos = input.charpos

        while input.skip_until(DEFAULT_REGEXP)
          mode = input.captures[0]
          code = input.captures[2]

          l_strip = input.captures[1] == MODE_STRIP
          l_slurp = input.captures[1] == MODE_SLURP

          r_strip = input.captures[3] == MODE_STRIP
          r_slurp = input.captures[3] == MODE_SLURP

          # <% ... %>
          # ^
          #
          # <% ... %>
          #         ^
          l_tag_pos = input.charpos - input.matched_charsize
          r_tag_pos = input.charpos - 1

          # foo
          #   <% ... %>
          # ^
          #     bar
          #
          # foo
          #   <% ... %>
          #     bar
          # ^
          c_line_pos = (input.string.rindex(/\n/, l_tag_pos) || -1) + 1
          n_line_pos = (input.string.index(/\n/, r_tag_pos) || input.string.length - 1) + 1

          # foo
          #    ^
          #   <% ... %>
          #     bar
          l_space_start_pos = 0
          unless l_tag_pos == l_space_start_pos
            l_space_start_pos = (input.string.rindex(/\S/, l_tag_pos - 1) || -1) + 1

            # Avoid revisiting left whitespace that was a prior tag's right whitespace
            l_space_start_pos = [l_space_start_pos, p_pos].max
          end

          # foo
          #   <% ... %>
          #     bar
          #    ^
          r_space_end_pos = input.string.length - 1
          unless r_tag_pos == r_space_end_pos
            r_space_end_pos = (input.string.index(/\S/, r_tag_pos + 1) || input.string.length) - 1
          end

          text = input.string[p_pos...l_space_start_pos]

          l_line_text = input.string[c_line_pos...l_tag_pos]
          r_line_text = input.string[(r_tag_pos + 1)...n_line_pos]

          l_space = input.string[l_space_start_pos...l_tag_pos]
          r_space = input.string[(r_tag_pos + 1)..r_space_end_pos]

          if l_strip
            l_space = ""
          elsif l_slurp
            l_space = input.string[l_space_start_pos...c_line_pos]
          end

          if r_strip
            r_space = ""
          elsif r_slurp
            r_space = (r_space_end_pos + 1 < n_line_pos) ? "" : "\n"
          end

          output << "#{buffer_var} << #{text.dump}\n"

          case parse(mode, code)

          # <% %>
          when :code
            # Move position past right whitespace to avoid revisiting it in the next tag
            input.charpos = r_space_end_pos + 1

            if l_line_text.blank? && r_line_text.blank?
              # If the line is blank, ensure that this tag does not add any whitespace from its presence alone
              l_space = input.string[l_space_start_pos...c_line_pos] if !l_strip && !l_slurp

              if !r_strip && !r_slurp
                r_space = input.string[n_line_pos..r_space_end_pos]

                # But if this tag is immediately followed by another tag
                # then defer the right whitespace here to be left whitespace there
                if input.match?(DEFAULT_REGEXP)
                  r_space = ""
                  input.charpos = n_line_pos
                end
              end
            end

            output << "#{buffer_var} << #{l_space.dump}\n"
            output << "#{code.strip}\n"
            output << "#{buffer_var} << #{r_space.dump}\n"

          # <% if ... %>
          when :code_start
            # Move position past right whitespace to avoid revisiting it in the next tag
            input.charpos = r_space_end_pos + 1

            if l_line_text.blank? && r_line_text.blank?
              # If the line is blank, ensure that this tag does not add any whitespace from its presence alone
              l_space = input.string[l_space_start_pos...c_line_pos] if !l_strip && !l_slurp

              if !r_strip && !r_slurp
                r_space = input.string[n_line_pos..r_space_end_pos]

                # But if this tag is immediately followed by another tag
                # then defer the right whitespace here to be left whitespace there
                if input.match?(DEFAULT_REGEXP)
                  r_space = ""
                  input.charpos = n_line_pos
                end
              end
            end

            stack.push(:nocapture)

            output << "#{buffer_var} << #{l_space.dump}\n"
            output << "#{code.strip}\n"
            output << "#{buffer_var} << #{r_space.dump}\n"

          # <% end %>
          when :code_end
            # Move position past right whitespace to avoid revisiting it in the next tag
            input.charpos = r_space_end_pos + 1

            if l_line_text.blank? && r_line_text.blank?
              # If the line is blank, ensure that this tag does not add any whitespace from its presence alone
              l_space = input.string[l_space_start_pos...c_line_pos] if !l_strip && !l_slurp

              if !r_strip && !r_slurp
                r_space = input.string[n_line_pos..r_space_end_pos]

                # But if this tag is immediately followed by another tag
                # then defer the right whitespace here to be left whitespace there
                if input.match?(DEFAULT_REGEXP)
                  r_space = ""
                  input.charpos = n_line_pos
                end
              end
            end

            stack.pop

            output << "#{buffer_var} << #{l_space.dump}\n"
            output << "#{code.strip}\n"
            output << "#{buffer_var} << #{r_space.dump}\n"
          when :expression
            # Defer the right whitespace here to the next tag's left whitespace
            input.charpos = r_tag_pos + 1

            if r_strip
              input.charpos = r_space_end_pos + 1
            elsif r_slurp
              input.charpos = [r_space_end_pos + 1, n_line_pos - 1].min
            end

            output << "#{buffer_var} << #{l_space.dump}\n"
            output << "#{buffer_var} << (#{code.strip}).to_s\n"
          when :capture_expression_start
            # Defer the right whitespace here to the next tag's left whitespace
            input.charpos = r_tag_pos + 1

            if r_strip
              input.charpos = r_space_end_pos + 1
            elsif r_slurp
              input.charpos = [r_space_end_pos + 1, n_line_pos - 1].min
            end

            stack.push(:capture)

            output << "#{buffer_var} << #{l_space.dump}\n"
            output << <<~RB
              begin
              #{buffers_var} ||= []
              #{buffers_var} << #{buffer_var}
              #{buffer_var} = #{buffer_val}
              #{buffers_var}.last << (#{code.strip}
            RB
          when :capture_expression_end
            # Defer the right whitespace here to the next tag's left whitespace
            input.charpos = r_tag_pos + 1

            if r_strip
              input.charpos = r_space_end_pos + 1
            elsif r_slurp
              input.charpos = [r_space_end_pos + 1, n_line_pos - 1].min
            end

            stack.pop

            output << "#{buffer_var} << #{l_space.dump}\n"
            output << <<~RB
              #{buffer_var}
              #{code.strip}).to_s
              ensure
              #{buffer_var} = #{buffers_var}.pop
              end
            RB
          else
            raise
          end

          p_pos = input.charpos
        end

        output << "#{buffer_var} << #{input.rest.dump}\n"
        output << "#{buffer_var}.to_s\n"

        output.freeze
      end

      def parse(mode, code)
        case mode
        when "="
          parse_expression(code)
        when ""
          parse_code(code)
        end
      end

      def parse_expression(code)
        case code
        when BLOCK_START_REGEXP
          :capture_expression_start
        else
          :expression
        end
      end

      def parse_code(code)
        case code
        when BLOCK_END_REGEXP
          case stack.last
          when :capture
            :capture_expression_end
          when :nocapture
            :code_end
          end
        when ->(s) { s.blank? }
          :code
        else
          :code_start
        end
      end
    end
  end
end
