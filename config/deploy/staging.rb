# Figure out the name of the current local branch
def current_git_branch
  branch = `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
  puts "* Using branch: #{branch}"
  branch
end

set :stage, :staging

# set :deploy_to, '/home/luiz/SLR'
set :branch, current_git_branch
set :rails_env, 'production'

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.

server 'result.inf.ufsc.br', user: 'luiz', roles: %w{web app db}

# fetch(:default_env).merge!(rails_env: :staging)

# Sidekiq
# =======
# set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }
