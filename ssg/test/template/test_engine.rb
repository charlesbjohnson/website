# frozen_string_literal: true

require_relative "../config"

require "yaml"
require "pathname"

module SSG
  class Template
    class TestEngine < Minitest::Test
      class << self
        def fixture
          @fixture ||= YAML.load_file(fixture_path)
        end

        def fixture_binding
          @fixture_binding ||= Class.new do
            def binding
              Kernel.binding
            end

            def fixture
              "-#{yield}-"
            end
          end.new.binding
        end

        private

        def fixture_path
          @fixture_path ||= Pathname.new(__FILE__).sub_ext("").join("./fixture.yml")
        end
      end

      fixture.each_with_index do |(source, output), i|
        define_method(:"test_#{i}") do
          assert_equal(output, eval(Engine.render(source), self.class.fixture_binding)) # rubocop:disable Security/Eval
        end
      end
    end
  end
end
