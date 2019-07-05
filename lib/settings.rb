# frozen_string_literal: true

$LOAD_PATH.unshift("./lib")

Encoding.default_external = "UTF-8"

require "encrypted_settings"

# module Settings
#   class << self
#     attr_accessor :config

#     def configure
#       self.config ||= UidsEncoder.new
#       yield(config)
#     end
#   end
# end

environment = ENV["RACK_ENV"] || ENV["RAILS_ENV"] || ENV["ENV"] || ENV["ENVIRONMENT"] || "development"
Settings = EncryptedSettings.new(environment).read
