require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require "rails/application"
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.filter_run focus: true
    config.use_transactional_fixtures = true
    config.run_all_when_everything_filtered = true
    config.treat_symbols_as_metadata_keys_with_true_values = true
  end
end

Spork.each_run do
  FactoryGirl.reload
end
