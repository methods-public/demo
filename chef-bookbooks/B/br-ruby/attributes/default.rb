#
# Cookbook Name:: br-ruby
# Attributes:: default
#

default['ruby'].tap do |ruby|
  ruby['versions'] = []
  ruby['install_path'] = '/opt/rubies'
  ruby['owner'] = 'root'
  ruby['group'] = 'root'
  ruby['mode'] = '0755'
  ruby['dependencies'] = []
  ruby['gems'] = { 'bundler' => '>= 0' }
  ruby['installer'] = 'ruby_build'
  ruby['installers'].tap do |installers|
    installers['ruby_build'].tap do |ruby_build|
      ruby_build['path'] = '/opt/ruby-build'
      ruby_build['environment'] = {}
      ruby_build['repository'] = 'https://github.com/sstephenson/ruby-build.git'
      ruby_build['revision'] = 'master'
    end
  end
end
