set :application, 'mongoid-unicorn-capistrano'
set :repo_url, 'https://github.com/honkimi/mongoid-unicorn-capistrano.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

set :rbenv_type, :system # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.0-rc1'
set :rbenv_path, '/opt/rbenv' 
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :unicorn_rack_env, :production
set :unicorn_bin, 'unicorn_rails'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :setup_config do
    on roles(:app) do
      sudo "ln -nfs #{current_path}/config/nginx.conf /usr/local/nginx/sites-enabled/#{fetch(:application)}"
    end
  end
  after "deploy:started", "deploy:setup_config"

  after :finishing, 'deploy:cleanup'
end

# app IS NOT preloaded
after 'deploy:restart', 'unicorn:reload'    
# app preloaded
after 'deploy:restart', 'unicorn:restart'   
# before_fork hook implemented (zero downtime deployments)
after 'deploy:restart', 'unicorn:duplicate' 

