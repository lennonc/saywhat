source 'https://rubygems.org'

gem 'rails', '3.2.13'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

# use postgresql in production
group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'twitter-bootstrap-rails', '2.2.6'
  gem 'bootstrap-datepicker-rails'
  # gem 'calendar_date_select', :git => 'git://github.com/paneq/calendar_date_select.git'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem "less-rails" #make twitter bootstrap work
  gem 'uglifier', '>= 1.0.3'
end

# gem 'jquery-rails'

gem "rspec-rails", :group => [:test, :development]
group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', :require => "bcrypt"

gem 'will_paginate', '~> 3.0'
gem 'bootstrap-will_paginate'
gem 'koala'
gem 'awesome_print'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
