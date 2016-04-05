# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_user_roles'
  s.version     = '1.2.1'
  s.summary     = 'Advanced user roles for Solidus.'
  s.description = 'Advanced user roles for Solidus.'
  s.required_ruby_version = '>= 2.0.0'

  s.author    = 'Allison Reilly'
  s.email     = 'allie.reilly@boomer.digital'
  s.homepage  = 'http://boomer.digital'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency "solidus_core", '~> 1.2'

  # s.add_development_dependency "solidus_backend", '~> 1.2'
  # s.add_development_dependency "solidus_frontend", '~> 1.2'
  s.add_development_dependency 'capybara', '~> 2.4'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.1'
  s.add_development_dependency 'sass-rails', '~> 5.0.0.beta1'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
