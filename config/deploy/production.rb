set :domain, "178.62.60.166"
server '178.62.60.166', :app, :web, :db, primary: true

set :branch, "master"

set :rails_env, "production"

role :web, domain
role :app, domain
role :db,  domain, :primary => true