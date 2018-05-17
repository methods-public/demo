action :add do
  run_context.include_recipe "sysctl::service"

  sysctld_file = template ::File.join("/etc/sysctl.d/", "#{new_resource.name}.conf") do
    source "sysctl.d.erb"
    owner "root"
    group "root"
    mode "0644"
    cookbook "sysctl_d"
    variables :variables => new_resource.params
    notifies :restart, "service[procps]", :immediately
  end

  new_resource.updated_by_last_action(sysctld_file.updated_by_last_action?)
end

action :remove do
  run_context.include_recipe "sysctl::service"

  sysctld_file = file ::File.join("/etc/sysctl.d/", "#{new_resource.name}.conf") do
    action :delete
    notifies :restart, "service[procps]", :immediately
  end

  new_resource.updated_by_last_action(sysctld_file.updated_by_last_action?)
end
