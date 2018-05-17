execute 'udevadm trigger' do
  command 'udevadm trigger --type=devices --subsystem-match=block'
  action :nothing
end.action(:run)

include_recipe 'chef_filesystem::packages' unless node['filesystem'].nil?
include_recipe 'chef_filesystem::format' unless node['filesystem']['format'].nil?
include_recipe 'chef_filesystem::config' unless node['filesystem']['config'].nil?
include_recipe 'chef_filesystem::mount' unless node['filesystem']['mount'].nil?
