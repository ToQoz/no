# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'no/version'

Gem::Specification.new do |spec|
  spec.name          = "no"
  spec.version       = NO::VERSION
  spec.authors       = ["Takatoshi Matsumoto"]
  spec.email         = ["toqoz403@gmail.com"]
  spec.summary       = %q{Support creating null object in Ruby.}
  spec.description   = %q{Support creating null object in Ruby. This basically behaves as nil and when a method is not found, returns nil.}
  spec.homepage      = "https://github.com/ToQoz/no"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
