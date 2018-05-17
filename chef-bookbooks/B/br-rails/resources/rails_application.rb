#
# Cookbook Name:: br-rails
# Resource:: rails_application
#

resource_name :rails_application

actions :configure, :install, :migrate
default_action :configure

attribute :name, kind_of: String, name_attribute: true, required: true
attribute :root, kind_of: String, required: true
attribute :ruby, kind_of: Hash, required: true
attribute :environment, kind_of: Hash, default: {}
attribute :config, kind_of: Hash, default: {}
attribute :commands, kind_of: Hash, default: {}
