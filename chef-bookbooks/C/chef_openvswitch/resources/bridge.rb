actions :create, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :protocols, kind_of: Array

def initialize(*args)
  super
  @action = :create
end
