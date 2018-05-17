actions :create, :remove
default_action :create

attribute :service_name, :kind_of => String, :name_attribute => true
attribute :service_prefix, :kind_of => String, :default => 'jackal'
attribute :configuration, :kind_of => Hash, :default => Mash.new
attribute :overrides, :kind_of => Array, :default => Array.new
attribute :system_packages, :kind_of => Array, :default => Array.new
attribute :gem_packages, :kind_of => Array, :default => Array.new
attribute :user, :kind_of => String
