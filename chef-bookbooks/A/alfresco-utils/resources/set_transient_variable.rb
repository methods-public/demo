actions :create
default_action :create

resource_name :transient_variable

property :variable_name, String, name_property: true
property :variable_value

action :create do
  r = new_resource
  node.run_state[r.variable_name] = r.variable_value
end
