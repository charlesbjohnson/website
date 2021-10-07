# frozen_string_literal: true

module SSG
  class CLI
    class << self
      # @param [Array<String>] args
      def main(args)
        if args.first == "serve"
          Site.serve
        else
          Site.build
        end
      end
    end
  end
end
