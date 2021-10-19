# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'boxtal_lite/version'

Gem::Specification.new do |spec|
  spec.name          = 'boxtal_lite'
  spec.version       = BoxtalLite::VERSION
  spec.authors       = ['Moncef Abdat']
  spec.email         = ['abdatmoncef9@gmail.com']

  spec.summary       = %q{Boxtal.com API client}
  spec.description   = %q{Client to access boxtal.com shipment API}
  spec.homepage      = 'https://github.com/Kubical-DevOps/BoxtalLite'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 1.0'
  spec.add_dependency 'faraday_middleware', '~> 1.1'
  spec.add_dependency 'multi_xml'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'builder'
  spec.add_dependency 'nokogiri', '~> 1.6'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'webmock'
end
