# frozen_string_literal: true

module SSG
  class Template
    # @param [SSG::File] file
    def initialize(file)
      self.file = file
    end

    # @param [SSG::Component] component
    # @yieldparam [SSG::Component] component
    # @return [String]
    def render(component = nil, &block)
      eval(compiled, component.instance_eval { binding(&block) }) # rubocop:disable Security/Eval
    end

    # @return [String]
    def type
      @type ||= file.abs_path.sub_ext("").extname[1..]
    end

    private

    def compiled
      @compiled ||= Engine.render(file.content)
    end

    attr_accessor :file
  end
end
