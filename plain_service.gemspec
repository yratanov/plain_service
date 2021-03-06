# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plain_service/version'

Gem::Specification.new do |spec|
  spec.name          = "plain_service"
  spec.version       = PlainService::VERSION
  spec.authors       = ["yratanov"]
  spec.email         = ["organium@gmail.com"]
  spec.description   = "Plain Service object implementation"
  spec.summary       = "Base class for your service objects"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "virtus"
  spec.add_runtime_dependency "rails", ['>= 3.2']

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
