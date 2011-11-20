set :user, "deploy"
set :application, "bremen"
set :domain, "#{application}.innovated.de"
set :deploy_to, "/var/www/#{application}"
set :repository, "git://github.com/dbloete/OpenData-Bremen.git"
set :bundle_cmd, "/usr/local/rvm/gems/ruby-1.9.2-p290@global/bin/bundle"
set :rake_cmd, "#{bundle_cmd} exec rake"
set :skip_scm, false
set :copy_shared, {
  'config/database.yml' => 'config/database.yml' }
set :symlinks, {
  'assets'              => 'public/assets',
  'config/database.yml' => 'config/database.yml' }
set :deploy_tasks, %w(
  vlad:update
  vlad:symlink
  vlad:bundle:install
  vlad:assets:precompile
  vlad:migrate
  vlad:start_app
  vlad:cleanup)

role :app, domain
role :web, domain
role :db,  domain, :primary => true

require 'bundler/vlad'