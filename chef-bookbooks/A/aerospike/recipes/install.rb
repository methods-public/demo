#
# Cookbook:: aerospike
# Recipe:: install
#

server_pkg_dir = ::File.join(node['aerospike']['server']['pkg']['dir'],
                             node['aerospike']['server']['version'])

directory server_pkg_dir do
  recursive true
end

tar_extract node['aerospike']['server']['pkg']['url'] do
  headers    node['aerospike']['server']['pkg']['headers']
  checksum   node['aerospike']['server']['pkg']['checksum']
  target_dir server_pkg_dir
  tar_flags  ['--strip 1']
  creates    ::File.join(server_pkg_dir, 'SHA256SUMS')
end

# make sure python is installed
package 'python' do
end

package 'aerospike-server' do
  package_name "aerospike-server-#{node['aerospike']['server']['edition']}"
  case node['platform_family']
  when 'debian'
    provider Chef::Provider::Package::Dpkg
  when 'rhel'
    provider Chef::Provider::Package::Rpm
  end
  source lazy { ::Dir["#{server_pkg_dir}/aerospike-server-*"].first }
  action :upgrade
end
