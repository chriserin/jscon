# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jscon/version'

Gem::Specification.new do |spec|
  spec.name          = "jscon"
  spec.version       = Jscon::VERSION
  spec.authors       = ["Christopher Erin"]
  spec.email         = ["chris.erin@gmail.com"]
  spec.description   = %q{js repl for rails}
  spec.summary       = %q{js repl for rails}
  spec.homepage      = "https://github.com/chriserin/jscon"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ['jscon'] #spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "easy_repl"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
