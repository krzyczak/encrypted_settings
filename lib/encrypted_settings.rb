# frozen_string_literal: true

require "openssl"
require "yaml"
require "tempfile"
require "ostruct"
require "fileutils"
require "json"

class EncryptedSettings
  KEY_FILE_PATH = ".settings_encryption_key"

  def initialize(env, editor: ENV["EDITOR"], key: nil)
    key ||= ENV["SETTINGS_ENCRYPTION_KEY"]
    key = File.read(KEY_FILE_PATH).strip if key.nil? && File.exist?(KEY_FILE_PATH)
    raise "Invalid Encryption Key" if key.nil? || key.length != 32

    @key = key
    @editor = editor || "sub --wait"

    @settings_path = "config/settings_#{env}.yml.enc"
  end

  def read
    File.binread(settings_path)
      .then(&self.method(:decrypt))
      .then(&YAML.method(:load))
      .then(&JSON.method(:dump))
      .then { |config| JSON.parse(config, object_class: OpenStruct) }
  end

  def edit
    # TODO: refactor into a few smaller methods.
    FileUtils.mkdir_p("config")
    content = ""
    content = File.binread(settings_path) if File.exist?(settings_path)
    tmp = Tempfile.new(["settings", ".yml"])
    tmp.rewind
    tmp.write(YAML.safe_load(decrypt(content)).to_yaml) unless content.empty?
    tmp.close
    system("#{editor} #{tmp.path}")

    File.unlink(settings_path) if File.exist?(settings_path)

    File.binwrite(settings_path, encrypt(File.read(tmp.path)))

    tmp.unlink
  end

  private

  attr_reader :key, :editor, :settings_path

  def encrypt(plain_text)
    cipher = OpenSSL::Cipher::AES256.new(:CBC)
    cipher.encrypt
    cipher.iv = "\xAA6RC\x98:?o_\xBD\x95|\xF6\x0E\xD7\xC5" # cipher.random_iv
    cipher.key = key
    cipher.update(plain_text) + cipher.final
  rescue ArgumentError
    ""
  end

  def decrypt(cipher_text)
    decipher = OpenSSL::Cipher::AES256.new(:CBC)
    decipher.decrypt
    decipher.iv = "\xAA6RC\x98:?o_\xBD\x95|\xF6\x0E\xD7\xC5"
    decipher.key = key
    decipher.update(cipher_text) + decipher.final
  end
end


