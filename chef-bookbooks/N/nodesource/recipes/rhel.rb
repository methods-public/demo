file = "nodejs-#{node[:node][:version]}nodesource.el#{node['platform_version'].to_i}.#{node[:kernel][:machine]}.rpm"

# Node have decided to be annoying and change the filename for EPEL 7
if node['platform_version'].to_i == 7
  file = "nodejs-#{node[:node][:version]}nodesource.el#{node['platform_version'].to_i}.centos.#{node[:kernel][:machine]}.rpm"
end

href = [
  "#{node[:node][:schema]}:/",
  node[:node][:host],
  "pub_#{node[:node][:major_version]}",
  'el',
  node['platform_version'].to_i,
  node[:kernel][:machine],
  file,
].join('/')

remote_file "#{Chef::Config[:file_cache_path]}/#{file}" do
  source href
  action :create_if_missing
  checksum node[:node][:checksum]
  notifies :install, "package[#{Chef::Config[:file_cache_path]}/#{file}]", :immediately
end

package "#{Chef::Config[:file_cache_path]}/#{file}" do
  action :nothing
end
