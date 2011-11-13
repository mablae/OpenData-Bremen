set :user, "deploy"
set :application, "bremen"
set :domain, "#{application}.com"
set :deploy_to, "/var/www/#{application}"
set :repository, "PLEASE_SET_THE_REPOSITORY_LOCATION"
set :bundle_cmd, "/usr/local/bin/bundle"
set :skip_scm, false
set :copy_shared, {
  'config/database.yml' => 'config/database.yml' }
set :symlinks, {
  'assets'              => 'public/assets',
  'config/database.yml' => 'config/database.yml' }
# Revision defaults to master
# set :revision, "origin/develop"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

require 'bundler/vlad'

# If Vlad does not find some commands, try the following:
#
# To enable per user PATH environments for ssh logins you
# need to add to your sshd_config:
# PermitUserEnvironment yes
#
# After that, restart sshd!
#
# Then in your "users" ssh home directory (~/.ssh/environment),
# add something to this effect (your mileage will vary):
# PATH=/opt/ruby-1.8.7/bin:/usr/local/bin:/bin:/usr/bin
#
# For details on that, see:
# http://zerobearing.com/2009/04/27/capistrano-rake-command-not-found
#
# Maybe you also need to configure SSH Agent Forwarding:
#
# $ ssh-add ~/.ssh/<private_keyname>
#
# Edit your ~/.ssh/config file and add something like this:
# Host <name>
#   HostName <ip or host>
#   User <username>
#   IdentityFile ~/.ssh/<filename>
#   ForwardAgent yes
#
# For details on that, see:
# http://jordanelver.co.uk/articles/2008/07/10/rails-deployment-with-git-vlad-and-ssh-agent-forwarding/
