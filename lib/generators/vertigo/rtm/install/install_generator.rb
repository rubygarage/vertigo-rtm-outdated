require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module Vertigo
  module Rtm
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        include ::Rails::Generators::Migration

        source_root File.expand_path('../templates', __FILE__)
        argument :user_class_name, type: :string, default: 'User'

        def self.next_migration_number(dirname)
          next_migration_number = current_migration_number(dirname) + 1
          ActiveRecord::Migration.next_migration_number(next_migration_number)
        end

        def copy_initializer_file
          template('initializer.rb', 'config/initializers/vertigo_rtm.rb')
        end

        def copy_migration_file
          migration_template('migration.rb', destination)
        end

        delegate :table_name, to: :user_class

        def migration_version
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end

        private

        def user_class
          user_class_name.constantize
        end

        def destination
          "db/migrate/add_vertigo_rtm_status_to_#{table_name}.rb"
        end
      end
    end
  end
end
