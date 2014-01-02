set :stage, :vagrant

role :app, %w{vagrant@127.0.0.1}
role :web, %w{vagrant@127.0.0.1}
role :db,  %w{vagrant@127.0.0.1}

set :ssh_options, :port => "2222"

