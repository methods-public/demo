source 'https://rubygems.org'

# Uncomment these lines if you want to live on the Edge:
#
# group :development do
#   gem "berkshelf", github: "berkshelf/berkshelf"
#   gem "vagrant", github: "mitchellh/vagrant", tag: "v1.6.3"
# end
#
# group :plugins do
#   gem "vagrant-berkshelf", github: "berkshelf/vagrant-berkshelf"
#   gem "vagrant-omnibus", github: "schisamo/vagrant-omnibus"
# end

group :lint do
  gem 'foodcritic', '~> 4.0'
  gem 'rubocop'
end

group :unit do
  gem 'berkshelf', '~> 3.2'
  gem 'chefspec', '~> 4.3'
end

group :kitchen do
  gem 'test-kitchen', '~> 1.4'
  gem 'kitchen-vagrant', '~> 0.18'
end

# group :os do
#   gem 'winrm-transport'
#   gem 'dmg'
# end
