include_recipe "mono3::_#{node['platform_family']}"

if platform_family?('rhel', 'fedora')
  include_recipe 'yum'
  include_recipe 'yum-epel'
elsif platform_family?('debian')
  include_recipe 'apt'
else
  raise "Platform #{node['platform']} not supported"
end

if node['mono3']['install_method'] == 'source'
  include_recipe 'mono3::_source'
elsif node['mono3']['install_method'] == 'package'
  package 'mono-complete'
else
  raise "Installation method #{node['mono3']['install_method']} not supported"
end
