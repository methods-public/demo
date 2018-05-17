#
# Cookbook Name:: br-ruby
# Resource:: ruby_build
#

resource_name :ruby_build

actions :install

attribute :version, kind_of: String, name_attribute: true, required: true
attribute :install_path, kind_of: String, default: '/opt/rubies'
attribute :owner, kind_of: String, default: 'root'
attribute :group, kind_of: String, default: 'root'
attribute :mode, kind_of: String, default: '0755'
attribute :path, kind_of: String, default: '/opt/ruby-build'
attribute :environment, kind_of: Hash, default: {}
attribute :repository, kind_of: String, default: 'https://github.com/sstephenson/ruby-build.git'
attribute :revision, kind_of: String, default: 'master'
