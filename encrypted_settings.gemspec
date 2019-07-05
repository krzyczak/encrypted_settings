# encoding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "encrypted_settings/version"

Gem::Specification.new do |spec|
  spec.name          = "encrypted_settings"
  spec.version       = EncryptedSettings::VERSION
  spec.authors       = ["Krzysztof Kaczmarczyk"]

  spec.summary       = "Encrypts settings so that they can be stored in the repository."
  spec.description   = "Similar to Rails encrypted secrets but with multiple environments."
  spec.homepage      = "https://github.com/krzyczak/encrypted_settings"
  spec.license       = "MIT"

  # # Prevent pushing this gem to RubyGems.org by setting "allowed_push_host", or
  # # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to "http://mygemserver.com""
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
