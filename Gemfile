source 'http://rubygems.org'

gem 'rails' #, '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

platform :ruby do
  gem 'sqlite3'
end

platform :jruby do
  gem 'activerecord-jdbcsqlite3-adapter'
  gem 'bcrypt-ruby'
  gem 'jruby-openssl'
end

# gem 'wash_out', :git => 'git://github.com/roundlake/wash_out.git'
gem 'wash_out', :git => 'https://github.com/roundlake/wash_out.git'
gem 'savon'
gem 'colored'
gem 'redcarpet'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'mysql', '2.8.1'

gem 'composite_primary_keys'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end
