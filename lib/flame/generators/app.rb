require "rails/generators"
require "rails/generators/rails/app/app_generator"
require "byebug"

module Flame
  module Generators
    class App < Rails::Generators::AppGenerator
      hide!
      def finish_template
        invoke :custom_template
        invoke :generators
        super
      end

      def custom_template
        build :configure_generators
      end

      def generators
        run("spring stop > /dev/null 2>&1 || true")
        rails_command "db:create"

        invoke "flame:testing"
        invoke "flame:cors"
        invoke "flame:devise"
        rails_command "db:create"
        invoke "flame:devise_jwt"
        invoke "flame:vite"

        generate("annotate:install")
        run("bundle exec standardrb --fix-unsafely")
        exit 0
      end

      protected

      def get_builder_class
        Flame::AppBuilder
      end
    end
  end
end