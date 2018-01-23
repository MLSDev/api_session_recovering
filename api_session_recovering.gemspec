$:.push File.expand_path('../lib', __FILE__)

require 'api_session_recovering/version'

Gem::Specification.new do |s|
  s.name        = 'api_session_recovering'
  s.version     = ApiSessionRecovering::VERSION
  s.authors     = ['']
  s.email       = ['']
  s.homepage    = 'https://github.com'
  s.summary     = 'A mountable api session recovering stuff'
  s.description = 'MLSdev'

  s.files = Dir["{ app, config, db, lib }/**/*"] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'nokogiri'
  s.add_dependency 'geocoder'
  s.add_dependency 'kaminari'
  s.add_dependency 'email_validator'
  s.add_dependency 'bcrypt'
  s.add_dependency 'swagger-blocks'

  s.add_development_dependency 'draper'
  s.add_development_dependency 'listen'

  # s.add_development_dependency 'appraisal'

  # Databases
  s.add_development_dependency 'pg'

  # Testing
  s.add_development_dependency 'spring'
  s.add_development_dependency 'spring-commands-rspec'

  # s.add_development_dependency 'wwtd'
  s.add_development_dependency 'rspec-core'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'rails-controller-testing'

  # s.add_development_dependency 'shoulda'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'shoulda-callback-matchers'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'faker'
end
