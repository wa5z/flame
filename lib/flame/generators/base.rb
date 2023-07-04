require "rails/generators"
require "rails/generators/base"

module Flame
  module Generators
    class Base < Rails::Generators::Base
      source_root File.expand_path("../../../../templates", __FILE__)
    end
  end
end
