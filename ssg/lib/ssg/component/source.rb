# frozen_string_literal: true

module SSG
  class Component
    class Source
      # @param [SSG::Component] component
      def initialize(component)
        self.component = component
      end

      # @return [Pathname]
      def abs_path
        @abs_path ||= Pathname.new(Module.const_source_location(component.name).first)
      end

      # @return [Pathname]
      def rel_path
        abs_path.relative_path_from(Site.config.dir_in)
      end

      # @return [Hash<String, SSG::File::StaticFile>]
      def static_files
        @static_files ||= child_files.each_with_object({}) do |file, h|
          h[file.abs_path.relative_path_from(abs_path.sub_ext("")).to_s] = file if file.static?
        end
      end

      # @return [Hash<String, SSG::File::TemplateFile>]
      def template_files
        @template_files ||= (sibling_files + child_files).each_with_object({}) do |file, h|
          h[file.abs_path.basename.to_s] = file if file.template?
        end
      end

      private

      attr_accessor :component

      def sibling_files
        File.glob(abs_path.sub_ext(".*")).reject { |file| file.abs_path == abs_path }
      end

      def child_files
        File.glob(abs_path.sub_ext("").join("**/*"))
      end
    end
  end
end
