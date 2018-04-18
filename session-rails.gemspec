$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "session/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'session-rails'
  s.version     = Session::Rails::VERSION
  s.authors     = ['Julien Dargelos']
  s.email       = ['contact@juliendargelos.com']
  s.homepage    = 'https://www.github.com/juliendargelos/session-rails'
  s.summary     = 'Makes user session smooth.'
  s.description = 'Makes user session smooth.'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
