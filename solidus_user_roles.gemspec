# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_user_roles'
  s.version     = '1.2.1'
  s.summary     = 'Advanced user roles for Solidus.'
  s.description = 'Advanced user roles for Solidus.'
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Allison Reilly'
  s.email     = 'allie.reilly@boomer.digital'
  s.homepage  = 'http://boomer.digital'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency "solidus_core", [">= 1.0.0", "< 3"]
  s.add_dependency 'solidus_support'

  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rspec-rails',  '~> 3.1'
  s.add_development_dependency 'rspec-its', '~> 1.0'
  s.add_development_dependency 'shoulda-matchers', '~> 2.7'
  s.add_development_dependency 'sass-rails', '~> 5.0.0.beta1'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
