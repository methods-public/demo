actions :create, :delete
default_action :create

attribute :bridge, kind_of: String, name_attribute: true
attribute :target, kind_of: [String, Array]
attribute :mode, kind_of: String

def initialize(*args)
  super
  @action = :create
end
