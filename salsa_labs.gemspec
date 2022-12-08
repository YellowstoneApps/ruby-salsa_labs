# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'salsa_labs/version'

Gem::Specification.new do |gem|
  gem.name          = "salsa_labs"
  gem.version       = SalsaLabs::VERSION
  gem.authors       = ['Josh Sharpe', 'Geoff Harcourt', 'Allison Sheren']
  gem.email         = ['josh@yellowstonehq.com']
  gem.description   = %q{A Ruby binding for the Salsa Labs (http://salsalabs.com) API.}
  gem.summary       = %q{Salsa Labs' API contains information about supporters, donations, and actions. This gem faciliates pulling that information into a Ruby application.}
  gem.homepage      = 'http://github.com/geoffharcourt/ruby-salsa_labs'
  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ['lib']
  gem.licenses      = ['MIT']

  gem.add_runtime_dependency 'faraday', '>= 0.8'
  gem.add_runtime_dependency 'nokogiri', '>= 1.5'

  gem.add_development_dependency 'guard', '~> 2'
  gem.add_development_dependency 'guard-rspec', '~> 4'
  gem.add_development_dependency 'rake', '~> 13'
  gem.add_development_dependency 'rspec', '~> 3'
  gem.add_development_dependency 'simplecov', '~> 0.8'
  gem.add_development_dependency 'vcr', '~> 2.8'
  gem.add_development_dependency 'webmock', '~> 1.16'
end
