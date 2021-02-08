source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.5.3"
gem "bcrypt", "3.1.12"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap-sass", "3.3.7"
gem "bootstrap-will_paginate", "1.0.0"
gem "carrierwave", "1.3.2"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "faker", "1.7.3"
gem "figaro"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails", "~> 4.3"
gem "mini_magick", "4.7.0"
gem "minitest", group: :test
gem "minitest-reporters", group: :test
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.3"
gem "rails-controller-testing"
gem "rails-ujs", "~> 0.1.0"
gem "rubocop", "~> 0.54.0", require: false
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "will_paginate", "~>3.1.7"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "sqlite3"
end

group :production do
  gem "fog", "1.42"
  gem "pg"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
