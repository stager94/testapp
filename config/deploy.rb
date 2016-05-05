require 'bundler/capistrano'
require "rvm/capistrano"
require 'capistrano_colors'
require 'capistrano/ext/multistage'
# require 'capistrano/slack'
# require 'capistrano/sidekiq'

set :default_stage, "production"

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :using_rvm, true
set :rvm_ruby_string, 'ruby-2.2.2'
set :rvm_type, :system

set :application, "testapp"
set :app_name, application
set :deploy_to, "/var/www/#{application}"
set :user,        'root'
set :use_sudo,    false

set :scm, :git
set :repository, "git@github.com:stager94/testapp.git"
set :deploy_via, :remote_cache

set(:unicorn_conf) { "#{deploy_to}/current/config/unicorn/#{fetch(:stage)}.rb" }
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :stack, :unicorn

set :sidekiq_timeout,    10
set :sidekiq_role,       :app
set :sidekiq_processes,  1

# before 'deploy:update_code', 'slack:starting'
# after 'sidekiq:start',  'slack:finished'

# after 'deploy:finalize_update', 'deploy:setup_sidekiq'

namespace :delayed_job do 
  desc "Restart the delayed_job process"
  task :restart, :roles => :app do
      run "cd #{deploy_to}/current; RAILS_ENV=#{rails_env} bin/delayed_job restart"
  end

  task :start, :roles => :app do
      run "cd #{deploy_to}/current; RAILS_ENV=#{rails_env} bin/delayed_job start"
  end

  task :stop, :roles => :app do
      run "cd #{deploy_to}/current; RAILS_ENV=#{rails_env} bin/delayed_job stop"
  end
end

namespace :deploy do
  desc "Start the application"
  task :start do
    run "cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end

  desc "Stop the application"
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  desc "Restart the application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end

  # task :setup_sidekiq, roles: [:app, :db, :web] do
  #   run "ln -s #{release_path}/config/sidekiq/#{stage}.yml #{release_path}/config/sidekiq.yml"
  # end

  namespace :web do
    desc "Disable web"
    task :disable, :roles => :web do
      begin
      run "if [[ !(-f #{deploy_to}/current/public/maintenance.html) ]] ; then ln -s #{deploy_to}/current/public/maintenance.html.not_active #{deploy_to}/current/public/maintenance.html ; else echo 'maintenance page already up'; fi"
      rescue
      end
    end

    desc "Enable web"
    task :enable, :roles => :web do
      begin
        run "rm #{deploy_to}/current/public/maintenance.html"
      rescue
      end
    end
  end

end