require 'rails_helper'
require 'generators/vertigo/rtm/install/install_generator'

module Vertigo::Rtm
  RSpec.describe Generators::InstallGenerator, type: :generator do
    destination File.expand_path('../../../../../tmp', __FILE__)

    def cleanup_destination_root
      FileUtils.rm_rf destination_root
    end

    before { cleanup_destination_root }

    context 'when arguments are passed' do
      before do
        capture(:stdout) {
          generator.create_file 'app/models/customer.rb' do
            "class Customer < ApplicationRecord\nend"
          end
        }

        require File.join(destination_root, 'app/models/customer.rb')

        prepare_destination
        run_generator %w(Customer)
      end

      it 'creates a initializer' do
        assert_file 'config/initializers/vertigo_rtm.rb',
          "Vertigo::Rtm.setup do |config|\n" \
          "  config.user_class = 'Customer'\n" \
          "  config.user_name_column = :name\n" \
          "  config.current_user_method = :current_user\n" \
          "end\n"
      end

      it 'creates migration file' do
        assert_migration 'db/migrate/add_vertigo_rtm_status_to_customers.rb',
          "class AddVertigoRtmStatusToCustomers < ActiveRecord::Migration[5.0]\n" \
          "  def self.up\n" \
          "    add_column :customers, :vertigo_rtm_status, :integer, default: 0\n" \
          "  end\n" \
          "\n" \
          "  def self.down\n" \
          "    remove_column :customers, :vertigo_rtm_status\n" \
          "  end\n" \
          "end\n"
      end
    end

    context 'when arguments are not passed' do
      before do
        prepare_destination
        run_generator
      end

      it 'creates initializer file' do
        assert_file 'config/initializers/vertigo_rtm.rb',
          "Vertigo::Rtm.setup do |config|\n" \
          "  config.user_class = 'User'\n" \
          "  config.user_name_column = :name\n" \
          "  config.current_user_method = :current_user\n" \
          "end\n"
      end

      it 'creates migration file' do
        assert_migration 'db/migrate/add_vertigo_rtm_status_to_users.rb',
          "class AddVertigoRtmStatusToUsers < ActiveRecord::Migration[5.0]\n" \
          "  def self.up\n" \
          "    add_column :users, :vertigo_rtm_status, :integer, default: 0\n" \
          "  end\n" \
          "\n" \
          "  def self.down\n" \
          "    remove_column :users, :vertigo_rtm_status\n" \
          "  end\n" \
          "end\n"
      end
    end
  end
end
