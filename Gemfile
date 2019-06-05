# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.6.3"

gem "bootsnap", ">= 1.3", require: false
gem "rails", "~> 5.2.2"
gem "rails-i18n", "~> 5.1"
gem "pg", ">= 0.18", "< 2.0"
gem "hiredis", "~> 0.6"
gem "redis", "~> 4.1", require: %w(redis redis/connection/hiredis)
gem "dalli", "~> 2.7"
gem "sidekiq", "~> 5.2"
gem "bcrypt", "~> 3.1.7"
gem "uglifier", ">= 1.3.0"
gem "sass-rails", "~> 5.0"
gem "mini_magick", "~> 4.8"
gem "warden", "~> 1.2"
gem "addressable", "~> 2.5"
gem "shrine", "~> 2.16"
gem "aws-sdk-s3", "~> 1.30"
gem "image_processing", "~> 1.7"
gem "image_optim", "~> 0.26"
gem "image_optim_pack"
gem "streamio-ffmpeg", "~> 3"
gem "redcarpet", "~> 3.4"
gem "font-awesome-rails", "~> 4.7"
gem "browser", "~> 2.5"
gem "recaptcha", "~> 4.13"
gem "diffy", "~> 3.3"
gem "whenever", "0.11.0", require: false

group :development, :test do
  gem "rubocop", "~> 0.60.0", require: false
  gem "rspec-rails", "~> 3.8"
  gem "puma", "~> 3.11"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

# Fix for deploy
gem "ed25519", ">= 1.2", "< 2.0"
gem "bcrypt_pbkdf", ">= 1.0", "< 2.0"

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # For rubymine
  gem "debase"
  gem "ruby-debug-ide"

  # Deployment
  gem "capistrano", "~> 3.11", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  gem "capistrano-rvm", git: "git://github.com/capistrano/rvm"
  gem "capistrano-passenger", git: "git://github.com/capistrano/passenger"
  gem "capistrano-sidekiq", git: "git://github.com/seuros/capistrano-sidekiq"
end

group :test do
  gem "factory_bot_rails", "~> 5"
  gem "capybara", "~> 3.9"
  gem "selenium-webdriver", "~> 3.14"
  gem "webmock", "~> 3.6"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
