use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create  do
  ovs = Mixlib::ShellOut.new("ovs-vsctl set-controller #{new_resource.bridge} #{new_resource.target.join(', ')}")
  ovs.run_command
  mode
end

action :delete do
  ovs = Mixlib::ShellOut.new("ovs-vsctl del-controller #{new_resource.name}")
  ovs.run_command
end

private

def mode
  if !new_resource.mode.empty?
    ovs = Mixlib::ShellOut.new("ovs-vsctl set-fail-mode #{new_resource.name} #{new_resource.mode}")
    ovs.run_command
  else
    ovs = Mixlib::ShellOut.new("ovs-vsctl del-fail-mode #{new_resource.name}")
    ovs.run_command
  end
end
