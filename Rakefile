#!/usr/bin/env rake
require File.expand_path('../config/application', __FILE__)
require 'rake'
include Rake::DSL

if Rails.env.development?
  begin
    require 'vlad'
    require 'vlad-extras'
    Vlad.load(scm: :git, web: :nginx, app: :passenger, type: :rails)
  rescue LoadError
    puts 'Could not load Vlad'
  end
end

Bremen::Application.load_tasks
