# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'showtime/version'

Gem::Specification.new do |spec|
  spec.name          = "showtime"
  spec.version       = Showtime::VERSION
  spec.authors       = ["Edd Sowden", "Oliver Spindler"]
  spec.email         = ["e@e26.co.uk"]
  spec.description   = %q{Automate website tours}
  spec.summary       = %q{Automate website tours}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "watir-webdriver"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
