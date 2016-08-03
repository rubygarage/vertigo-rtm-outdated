ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)

require 'spec_helper'
require 'rspec/rails'
require 'factory_girl_rails'
require 'faker'
require 'shoulda-matchers'
require 'database_cleaner'
require 'pundit/rspec'
require 'generator_spec'

Rails.backtrace_cleaner.remove_silencers!

Dir[Vertigo::Rtm::Engine.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include(FactoryGirl::Syntax::Methods)
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include(Request::JsonHelpers, type: :controller)
  config.include(ActionView::Helpers::TranslationHelper)
  config.include(ActionView::Context, type: :generator)

  config.use_transactional_fixtures = false

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
