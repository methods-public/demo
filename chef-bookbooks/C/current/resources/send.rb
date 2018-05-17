actions :enable, :disable
default_action :enable

attribute :name, :name_attribute => true, :kind_of => String, :required => true
attribute :filename, :kind_of => String, :required => true
attribute :tags, :kind_of => Array, :default => []
attribute :token, :kind_of => String, :default => lazy { node['current']['token'] }
attribute :user, :kind_of => String, :default => 'root'
