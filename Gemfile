source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"
gem 'pry'
gem 'rest-client'

gem 'delayed_job_active_record'
gem 'daemons'
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap'
gem 'haml'
gem 'best_in_place', '~> 3.0.1'
gem 'responders', '~> 2.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

	# RSpec for Rails-3+
	gem 'rspec-rails'
end

group :test do
	# Collection of testing matchers extracted from Shoulda
	gem 'shoulda-matchers', '~> 3.1'

	gem	'minitest'

	# A library for setting up Ruby objects as test data.
	gem 'factory_girl_rails'

	# Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing.
	gem 'database_cleaner'
end