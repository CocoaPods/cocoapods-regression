# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-regression/version'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-regression'
  spec.version       = CocoaPods::Regression::VERSION
  spec.authors       = ['Boris Bügling']
  spec.email         = ['boris@buegling.com']

  spec.summary       = 'Automation harness for CocoaPods regression tests.'
  spec.homepage      = 'https://github.com/CocoaPods/cocoapods-regression'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'cocoapods', '~> 0.38.2'
  spec.add_dependency 'xcode-install', '~> 0.9.3'
end
