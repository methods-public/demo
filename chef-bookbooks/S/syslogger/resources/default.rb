actions        :write
default_action :write

attribute      :message,  :kind_of => String, :name_attribute => true
attribute      :facility, :kind_of => String, :default => 'user'
attribute      :level,    :kind_of => String, :default => 'notice'
attribute      :tag,      :kind_of => String
attribute      :options,  :kind_of => String

def initialize(*args)
  super
  @action = :write
end
