source "https://rubygems.org"

ruby "2.7.0"

gem "dotenv-rails", groups: [:development, :test]
gem "bootsnap", "~> 1", require: false
gem "rails", "~> 6.0"
gem "rails-i18n", "~> 6"
gem "pg", ">= 0.18", "< 2.0"
gem "webpacker", "~> 4"
gem "bcrypt", "~> 3"
gem "mini_magick", "~> 4"
gem "oj", "~> 3"
gem "warden", "~> 1"
gem "browser", "~> 3"
gem "shrine", "~> 2"
gem "aws-sdk-s3", "~> 1"
gem "image_processing", "~> 1"
gem "image_optim", "~> 0"
gem "image_optim_pack"
gem "recaptcha", "~> 5"
gem "whenever", "~> 1", require: false
gem "pundit", "~> 2"
gem "draper", "~> 3"

group :development, :test do
  gem "standard"
  gem "rspec-rails"
  gem "puma"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

group :test do
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "json_matchers"
  gem "simplecov", require: false
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
