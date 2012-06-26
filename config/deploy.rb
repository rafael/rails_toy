set :application, "rails_toy"
set :repository,  "git@github.com:rafael/rails_toy.git"

set :scm, :git
role :web, "50.16.185.131" # Your HTTP server, Apache/etc
role :app, "50.16.185.131" # This may be the same as your `Web` server

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
#
default_run_options[:pty] = true
set :use_sudo, true
set :user, "rafael"
ssh_options[:auth_methods] = ["publickey"]
set :last_update_file, "deployed_at.txt"
set :deploy_to, "/home/rafael/#{application}"
set :deploy_via, :remote_cache

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
