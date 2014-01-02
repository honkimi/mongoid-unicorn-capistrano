# Set your full path to application.
app_path = "/var/www/current"

# Set unicorn options
worker_processes 1
preload_app true
timeout 180
listen "/tmp/unicorn.app.sock"
pid "#{app_path}/tmp/pids/unicorn.pid"

# Spawn unicorn master worker for user apps (group: apps)
user 'unicorn', 'unicorn' 

# Fill path to your app
working_directory app_path

# Should be 'production' by default, otherwise use other env 
rails_env = ENV['RAILS_ENV'] || 'production'

# Log everything to one file
stderr_path "log/unicorn.log"
stdout_path "log/unicorn.log"

