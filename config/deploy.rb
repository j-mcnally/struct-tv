# config valid only for Capistrano 3.1

require 'capistrano/cloudflare'

set :cloudflare_options, {
    :domain  => '',
    :email   => '',
    :api_key => ''
}

lock '3.3.5'

set :application, 'struct'
set :repo_url, ''

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do

  desc 'Compile app'

  task :compile do
    on roles(:app) do
      execute "cd /var/app/current; mix deps.get; mix compile"
      execute "cd /var/app/current; source /etc/default/struct && mix ecto.migrate Repo"
    end
  end

  task :send_ember do
    on roles(:app) do
      puts "Setup ember"
      pwd = `pwd`
      %x[rm -rf ember/dist]
      %x[cd ember; ember build --environment production]
      %x[cd #{pwd}]
      execute "rm -rf #{release_path}/ember; mkdir -p #{release_path}/ember"
      path = File.expand_path("../../ember/dist", __FILE__)
      puts path
      upload! path, "#{release_path}/ember", {:recursive => true}
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "sudo restart struct"
    end
  end

  before :restart, :send_ember
  before :restart, :compile

  after :publishing, :restart
  after :restart, :"cloudflare:cache:purge"

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do

    end
  end

end
