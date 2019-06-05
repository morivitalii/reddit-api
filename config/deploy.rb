lock "~> 3.11.0"

set :application, "app"
set :repo_url, "git@gitlab.com:dev1vitaly/reddit.git"
set :deploy_to, "/home/deploy/app"
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/uploads"