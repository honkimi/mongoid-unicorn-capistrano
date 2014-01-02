set :stage, :vagrant
#set :unicorn_config_rel_path, "config/unicorn"
#set :unicorn_config_filename, "vagrant.rb"

role :app, %w{vagrant@127.0.0.1}
role :web, %w{vagrant@127.0.0.1}
role :db,  %w{vagrant@127.0.0.1}

set :ssh_options, :port => "2222"

