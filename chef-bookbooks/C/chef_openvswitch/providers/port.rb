use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create do
  ovs = Mixlib::ShellOut.new("ovs-vsctl -- --may-exist add-port #{new_resource.bridge} #{new_resource.name}")
  ovs.run_command
  ovs = Mixlib::ShellOut.new("ovs-vsctl -- set Interface #{new_resource.name} type=#{new_resource.type} #{new_resource.options.map { |k, v| 'options:' + k.to_s + '=' + v.to_s }.join(' ')}")
  ovs.run_command
end

action :clear do
  ovs = Mixlib::ShellOut.new("ovs-vsctl -- clear --force Interface #{new_resource.name} type")
  ovs.run_command
  ovs = Mixlib::ShellOut.new("ovs-vsctl -- clear --force Interface #{new_resource.name} options")
  ovs.run_command
end

action :delete do
  ovs = Mixlib::ShellOut.new("ovs-vsctl -- --if-exists del-port #{new_resource.bridge} #{new_resource.name}")
  ovs.run_command
end
