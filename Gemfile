source 'https://rubygems.org'
ruby '2.5.1'

gem 'rails', '5.2.0'	# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rack-cors', require: 'rack/cors'
gem 'bootsnap'

gem 'jbuilder'			# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'sdoc', group: :doc # bundle exec rake doc:rails generates the API under doc/api.

gem 'openid_connect'  # Needed to probe remote IdP configuration. 

gem 'will_paginate'   # Better query pagination support.
gem 'jwt'		# All API calls require JWT-signed requests!
gem 'cancancan'	# Declarative authorization DSL.

gem 'puma'	    # Better web server
gem 'pg'	    # Only PostgreSQL is supported!
gem 'pg_search' # Full-text search. RAD!!!
gem 'redis'
# gem 'mongoid'

gem 'faker'		# For generating synthetic data.


group :development, :test do
  gem 'byebug'  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
end

group :development do
  # gem 'web-console', '~> 2.0'     # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'spring'    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'guard'
  gem 'railroady'
end
