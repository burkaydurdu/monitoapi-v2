source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.8"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use Puma as the app server
gem "puma", "~> 5.0"
# For process management
gem "foreman"
# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false
# For serialization
gem "active_model_serializers", "~> 0.8.0"
# For process management
gem "foreman"
# Health check
gem 'health_check'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"
# gem 'pact-consumer-minitest' for minitest
gem "pact"
# Authorizations
gem "pundit"
# For soft deletion
gem "paranoia"
# Make http fun again!
gem "httparty"

group :development do
  gem "listen", "~> 3.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "rubocop"
  gem "pry-rails"
  gem "annotate"
end

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]

  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "rspec-rails"
  gem "rspec_api_documentation"
  gem "webmock"
  gem "shoulda-matchers"
  gem "brakeman" # Static analysis tool for security vulnerabilities
  gem "bundler-audit" # Check dependencies' vulnerabilities
end

group :test do
  gem "simplecov", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
