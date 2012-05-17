# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'simplecov-cli/version'

Gem::Specification.new do |gem|
  gem.name = 'simplecov-cli'
  gem.version = "0.1.0"
  gem.platform = Gem::Platform::RUBY
  gem.authors = ["Joel Stimson"]
  gem.email = ['contact@cleanroomstudios.com']
  gem.homepage = 'http://github.com/stim371/simplecov-cli'
  gem.description = %Q{Quickly view a project's test coverage using the simplecov gem}
  gem.summary = gem.description

  gem.add_dependency 'simplecov'
  gem.add_development_dependency 'rspec'

  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']
end