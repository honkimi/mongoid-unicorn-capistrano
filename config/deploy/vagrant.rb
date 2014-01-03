set :stage, :vagrant
set :unicorn_env, "vagrant"

role :app, %w{vagrant@vagrant}
role :web, %w{vagrant@vagrant}
role :db,  %w{vagrant@vagrant}

set :ssh_options, :port => "2222"

