# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubifrost/version'

Gem::Specification.new do |spec|
  spec.name          = "rubifrost"
  spec.version       = RuBifrost::VERSION
  spec.authors       = ["Ben Pringle"]
  spec.email         = ["ben.pringle@gmail.com"]
  spec.description   = %q{A burning rainbow bridge between scripting languages}
  spec.summary       = %q{A burning rainbow bridge between scripting languages}
  spec.homepage      = ""
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
