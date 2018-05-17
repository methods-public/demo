actions        :scan
default_action :scan

attribute      :filename, :kind_of => String, :name_attribute => true
attribute      :options,  :kind_of => String
attribute      :target,   :kind_of => String, :default => 'localhost'
attribute      :output,   :kind_of => Symbol, :default => :normal, :equal_to => [:normal, :xml, :script_kiddie, :greppable]

def initialize(*args)
  super
  @action = :scan
end
