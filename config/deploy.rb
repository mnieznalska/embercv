set :application, "opencv"
set :repository,  "git@bitbucket.org:jakubn/opencv.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "88.198.76.142"                          # Your HTTP server, Apache/etc
role :app, "88.198.76.142"                          # This may be the same as your `Web` server
role :db,  "88.198.76.142", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

#If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

require 'rvm/capistrano'
require 'bundler/capistrano'

ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :use_sudo, true
set :user, "opencv"
set :deploy_to, "/home/opencv"
set :rails_env, "production"
set :rvm_type, :system
set :default_shell, "/bin/bash -l"
default_run_options[:pty] = true

set :keep_releases, 3
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  desc "Symlink shared/* files"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after "deploy:update_code", "deploy:symlink_shared"
before 'deploy:setup', 'rvm:install_rvm'
