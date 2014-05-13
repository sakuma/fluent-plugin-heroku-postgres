# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/heroku/postgres/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-heroku-postgres"
  spec.version       = Fluent::Plugin::Heroku::Postgres::VERSION
  spec.authors       = ["Naohiro Sakuma"]
  spec.email         = ["nao.bear@gmail.com"]
  spec.summary       = %q{fluent plugin to insert on Heroku Postgre.}
  spec.description   = %q{fluent plugin to insert on Heroku Postgre.}
  spec.homepage      = "https://github.com/n-sakuma/fluent-plugin-heroku-postgres"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
