require 'rubygems'
require 'spork'

Spork.prefork do
  require "rails/application"
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  require 'cucumber/rails'

  Capybara.default_selector = :css
  ActionController::Base.allow_rescue = false

  DatabaseCleaner.strategy = :transaction

  Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
    DatabaseCleaner.strategy = :truncation
  end

  Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
    DatabaseCleaner.strategy = :transaction
  end
end

Spork.each_run do
  FactoryGirl.reload
end
