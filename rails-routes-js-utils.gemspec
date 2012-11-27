# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-routes-js-utils/version'

Gem::Specification.new do |gem|
  gem.name          = "rails-routes-js-utils"
  gem.version       = Rails::Routes::Js::Utils::VERSION
  gem.authors       = ["Le Duc Duy"]
  gem.email         = ["me@duy.kr"]
  gem.description   = "Make rails route available via window.Routes"
  gem.summary       = "Make rails route available via window.Routes"
  gem.homepage      = ""

  gem.add_development_dependency 'rails'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
