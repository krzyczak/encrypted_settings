# frozen_string_literal: true

$LOAD_PATH.unshift("./lib")

environment = ENV["RACK_ENV"] || ENV["RAILS_ENV"] || ENV["ENV"] || ENV["ENVIRONMENT"] || "development"

Encoding.default_external = "UTF-8"

require "encrypted_settings"
require "pry"

namespace :settings do
desc "Initialize or edit encrypted settings file."
  task :edit do
    EncryptedSettings.new(environment).edit
  end

  desc "Read settings and print ot STDOUT"
  task :read do
    EncryptedSettings.new(environment).read
      .then(&OpenStructToHash.method(:parse))
      .then(&YAML.method(:dump))
      .then(&self.method(:puts))
  end
end

module OpenStructToHash
  def self.parse(object)
    object.marshal_dump.transform_values do |val|
      val.is_a?(OpenStruct) ? parse(val) : val
    end
  end
end
