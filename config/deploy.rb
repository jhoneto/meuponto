set :application, 'meuponto'
set :scm, :git
set :repo_url, 'git@github.com:jhoneto/meuponto.git'
#set :git_https_username, 'hamiltonoliveira'
#set :git_https_password, '30neto07'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/home/deploy/apps/meuponto" 
#set :deploy_via, :copy

set :format, :pretty
set :log_level, :debug
set :pty, false
set :deploy_via, :remote_cache

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{log}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

# RVM settings
set :rvm_type, :system
set :rvm_ruby_version, '2.0.0'

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5


namespace :deploy do
  desc "Deploy and run migrations"
  task :migrations do
    update
    migrate
    restart
    cleanup
  end
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
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

  after :finishing, 'deploy:cleanup'

end