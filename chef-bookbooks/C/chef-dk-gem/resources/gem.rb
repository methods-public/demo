# configure a gem using chefdk gemset

actions :install, :remove
default_action :install if defined?(default_action)

attribute :name, kind_of: String, name_attribute: true
attribute :user, kind_of: String, required: false, default: 'root'
attribute :version, kind_of: String, required: false, default: nil
