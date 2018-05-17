actions :create
default_action :create

resource_name :file_rename

property :old_value, String, name_property: true
property :new_value

action :create do
  r = new_resource
  ::File.rename(r.old_value, r.new_value) unless ::File.exist?(r.new_value)
end
