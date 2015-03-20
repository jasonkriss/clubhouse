require "rails/generators"

module Clubhouse
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def install_migrations
        Dir.chdir(Rails.root) { `rake clubhouse:install:migrations` }
      end

      def mount
        inject_into_file "config/routes.rb", after: "Rails.application.routes.draw do\n" do
          "  mount Clubhouse::Engine => \"/\"\n\n"
        end
      end

      def inject_into_member_model
        inject_into_class "app/models/user.rb", User do
          "  include Clubhouse::Memberable\n\n"
        end
      end

      def create_initializer
        copy_file "initializer.rb", "config/initializers/clubhouse.rb"
      end
    end
  end
end
