actions :create, :delete, :clear
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :bridge, kind_of: String
attribute :type, kind_of: String
attribute :options, kind_of: [Array, Hash, Mash]

def initialize(*args)
  super
  @action = :create
end
