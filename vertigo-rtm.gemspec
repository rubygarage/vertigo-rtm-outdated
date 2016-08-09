$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'vertigo/rtm/version'

Gem::Specification.new do |s|
  s.name        = 'vertigo-rtm'
  s.version     = Vertigo::Rtm::VERSION
  s.authors     = ['chubchenko']
  s.email       = ['artem.chubchenko@gmail.com']
  s.homepage    = 'https://github.com/rubygarage/vertigo-rtm'
  s.summary     = 'Real time messenger'
  s.description = s.summary
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.0'
  s.add_dependency 'active_model_serializers', '~> 0.10.0'
  s.add_dependency 'carrierwave', '~> 0.11.2'
  s.add_dependency 'pundit', '~> 1.1'
  s.add_dependency 'will_paginate', '~> 3.1.0'
  s.add_dependency 'jquery-rails'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'generator_spec'
  s.add_development_dependency 'coffeelint'
  s.add_development_dependency 'overcommit'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubycritic'
  s.add_development_dependency 'scss_lint'
end
