# Encrypted Settings
A gem like Rails 5 settings but with multiple environments.

# Usage

Implemented a library similar to rails 5 encrypted settings.

To read the settings and print out to STDOUT:
```bash
rake settings:read
```

To edit settings:
```bash
rake settings:edit
```

You might need to pass some environment variables:
```bash
RACK_ENV=development SETTINGS_ENCRYPTOION_KEY=DevelopmentSecretIsHardToBreak!! rake settings:edit
```

The key can also be put in a `.settings_encryption_key` file. In that case just:
```bash
RACK_ENV=production rake settings:edit
```

By default, it would use sublime (`sub --wait`) to edit the settings. If you prefer another editor you can pass the command in `EDITOR` env variable, eg.
```bash
EDITOR=vim rake settings:edit
```

The environment will be determined like this:
```ruby
environment = ENV["RACK_ENV"] || ENV["RAILS_ENV"] || ENV["ENV"] || ENV["ENVIRONMENT"] || "development"
```
