#
# Cookbook Name:: br-ruby
# Resource:: ruby
#

resource_name :ruby_runtime

actions :install, :remove

attribute :version, kind_of: String, name_attribute: true, required: true
attribute :install_path, kind_of: String, default: '/opt/rubies'
attribute :owner, kind_of: String, default: 'root'
attribute :group, kind_of: String, default: 'root'
attribute :mode, kind_of: String, default: '0755'
attribute :dependencies, kind_of: Array, default: []
attribute :gems, kind_of: Hash, default: {}
attribute :installer, kind_of: Hash, required: true
