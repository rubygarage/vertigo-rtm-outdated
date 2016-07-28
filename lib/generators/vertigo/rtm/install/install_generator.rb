require 'rails/generators/migration'
require 'rails/generators/active_record'

module Vertigo
  module Rtm
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        include ::Rails::Generators::Migration

        source_root File.expand_path('../templates', __FILE__)

        def self.next_migration_number(dirname)
          next_migration_number = current_migration_number(dirname) + 1
          ActiveRecord::Migration.next_migration_number(next_migration_number)
        end

        def copy_initializer_file
          copy_file \
            'initializer.rb',
            'config/initializers/vertigo_rtm.rb'
        end

        def copy_migration_file
          migration_template \
            'migration.rb',
            destination
        end

        def table_name
          Vertigo::Rtm.user_class.table_name
        end

        def migration_version
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end

        private

        def destination
          "db/migrate/add_vertigo_rtm_to_#{table_name}.rb"
        end
      end
    end
  end
end
