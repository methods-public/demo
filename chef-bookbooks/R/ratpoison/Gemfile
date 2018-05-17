source 'https://rubygems.org'

group :development, :test do
  gem 'berkshelf', git: 'https://github.com/berkshelf/berkshelf'
  gem 'foodcritic', '>= 3.0'
  gem 'chefspec',   '>= 3.1'
  gem 'rubocop'
  gem 'simplecov', :require => false, :group => :test
end

group :development do
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-docker'
  gem 'guard'
  gem 'guard-kitchen'
  gem 'guard-foodcritic', '>= 1.0'
  gem 'guard-rspec',      '>= 4.2'
  gem 'guard-rubocop'
end
