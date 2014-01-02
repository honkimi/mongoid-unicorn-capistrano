set :stage, :vagrant
set :unicorn_env, "vagrant"

role :app, %w{unicorn@127.0.0.1}
role :web, %w{unicorn@127.0.0.1}
role :db,  %w{unicorn@127.0.0.1}

set :ssh_options, :port => "2222"

