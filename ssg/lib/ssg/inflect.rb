# frozen_string_literal: true

module SSG
  module Inflect
    class << self
      # @param [String] s
      # @return [String]
      def dasherize(s)
        s.tr("_", "-")
      end

      # @param [String] s
      # @return [String]
      def demodulize(s)
        if (i = s.rindex("::"))
          s[(i + 2)..]
        else
          s
        end
      end

      # @param [String] s
      # @return [String]
      def underscore(s)
        return s.to_s unless /[A-Z-]|::/.match?(s)

        word = s.to_s.gsub("::", "/")
        word.gsub!(/([A-Z]+)(?=[A-Z][a-z])|([a-z\d])(?=[A-Z])/) { ($1 || $2) << "_" }
        word.tr!("-", "_")
        word.downcase!

        word
      end
    end
  end
end
