source "http://rubygems.org"

# Essentials
gem 'rake', '~> 0.9.2'
gem 'rails', '3.1.1'
gem 'bcrypt-ruby'
gem 'mysql2'
gem 'simple_form'
gem 'responders'
gem 'decent_exposure'
gem 'exception_notification'
gem 'settingslogic'
gem 'awesome_print'
gem 'haml-rails'
gem 'jquery-rails'
gem 'backbone-on-rails'
gem 'kaminari'
gem 'geocoder', :git => 'git://github.com/alexreisner/geocoder.git'
gem 'api_builder', :git => 'git://github.com/dbloete/api_builder.git'

# Test data and seeds
gem 'factory_girl_rails'
gem 'faker'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'compass', :git => 'git://github.com/chriseppstein/compass.git'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'bootstrap-sass'
  gem 'haml_coffee_assets'
  gem 'execjs'
end

group :development do
  gem 'mongrel', '1.2.0.pre2'
  gem 'active_reload'
  # Deployment
  gem 'vlad', :require => false
  gem 'vlad-git', :require => false
  gem 'vlad-extras', :require => false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'cucumber-rails'
  # Guard
  gem 'rb-fsevent', :require => false
  gem 'guard-bundler'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-livereload'
end

group :test do
  gem 'launchy'
  gem 'email_spec'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'fuubar'
  gem 'fuubar-cucumber'
  gem 'spork', '> 0.9.0.rc'
end
