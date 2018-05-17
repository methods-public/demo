use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create  do
  ovs = Mixlib::ShellOut.new("ovs-vsctl -- --may-exist add-br #{new_resource.name}")
  ovs.run_command
  unless new_resource.protocols.nil? || new_resource.protocols.empty?
    ovs = Mixlib::ShellOut.new("ovs-vsctl -- set bridge #{new_resource.name} protocols=#{new_resource.protocols.join(',')}")
    ovs.run_command
  end
end

action :delete do
  ovs = Mixlib::ShellOut.new("ovs-vsctl -- --if-exists del-br #{new_resource.name}")
  ovs.run_command
end
