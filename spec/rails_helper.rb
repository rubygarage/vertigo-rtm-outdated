ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'spec_helper'
require 'rspec/rails'
require 'factory_girl_rails'
require 'faker'
require 'shoulda-matchers'
require 'database_cleaner'

Rails.backtrace_cleaner.remove_silencers!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include(FactoryGirl::Syntax::Methods)
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.use_transactional_fixtures = false

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run show_in_doc: true if ENV['APIPIE_RECORD']

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
