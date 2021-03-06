# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-heroku-postgres"
  spec.version       = '0.0.5'
  spec.authors       = ["Naohiro Sakuma"]
  spec.email         = ["nao.bear@gmail.com"]
  spec.summary       = %q{fluent plugin to insert on Heroku Postgre.}
  spec.description   = %q{This gem is fluent plugin to insert on Heroku Postgre.}
  spec.homepage      = "https://github.com/sakuma/fluent-plugin-heroku-postgres"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'fluentd', "~> 0.10"
  spec.add_dependency 'pg', "~> 0.17"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", '~> 0'
  spec.add_development_dependency "pry", '~> 0'
end
