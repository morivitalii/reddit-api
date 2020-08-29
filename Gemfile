source "https://rubygems.org"

ruby "2.7.1"

gem "dotenv-rails", groups: [:development, :test]
gem "bootsnap", "~> 1", require: false
gem "rails", "~> 6.0"
gem "rails-i18n", "~> 6"
gem "pg", ">= 0.18", "< 2.0"
gem "webpacker", "~> 5"
gem "bcrypt", "~> 3"
gem "mini_magick", "~> 4"
gem "oj", "~> 3"
gem "warden", "~> 1"
gem "browser", "~> 4"
gem "aws-sdk-s3", "~> 1"
gem "image_processing", "~> 1"
gem "recaptcha", "~> 5"
gem "whenever", "~> 1", require: false
gem "pundit", "~> 2"
gem "draper", "~> 4"

group :development, :test do
  gem "puma"
  gem "standard"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

group :test do
  gem "shoulda-matchers"
  gem "json_matchers"
  gem "simplecov", require: false
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
