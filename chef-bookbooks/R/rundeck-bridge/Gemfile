source 'https://rubygems.org'

gem 'berkshelf'
gem 'chefspec',   '>= 4.2'
gem 'fauxhai',    '>= 2.2'
gem 'foodcritic', '>= 4.0'
gem 'rake'

gem 'kitchen-vagrant'

group :ec2 do
  gem 'test-kitchen'
  gem 'kitchen-ec2', :git => 'https://github.com/criteo-forks/kitchen-ec2.git', :branch => 'criteo'
  gem 'winrm'
  gem 'winrm-fs'
end
