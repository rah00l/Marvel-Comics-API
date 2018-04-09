# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marvel_comics_api/version'

Gem::Specification.new do |spec|
  spec.name          = "marvel-comics-api"
  spec.version       = MarvelComicsApi::VERSION
  spec.authors       = ["Rahul Patil"]
  spec.email         = ["rahulpatil2387@gmail.com"]
  spec.description   = %q{A Ruby wrapper for the Marvel Comics API}
  spec.summary       = %q{A Ruby wrapper for the Marvel Comics API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files = Dir["{lib,spec}/**/*", "[A-Z]*"] - ["Gemfile.lock"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_path = "lib"

  spec.add_dependency "httparty"
  spec.add_dependency "hashie"

  # Development Dependencies
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
