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
stderr_path "/var/log/unicorn/error.log"
stdout_path "/var/log/unicorn/sdtout.log"


before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end


