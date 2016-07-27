$:.push File.expand_path('../lib', __FILE__)

require 'vertigo/rtm/version'

Gem::Specification.new do |s|
  s.name        = 'vertigo-rtm'
  s.version     = Vertigo::Rtm::VERSION
  s.authors     = ['chubchenko']
  s.email       = ['artem.chubchenko@gmail.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of Vertigo::Rtm.'
  s.description = 'TODO: Description of Vertigo::Rtm.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.0'
  s.add_dependency 'active_model_serializers', '~> 0.10.0'
  s.add_dependency 'carrierwave', '~> 0.11.2'
  s.add_dependency 'pundit', '~> 1.1'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'database_cleaner'
end
