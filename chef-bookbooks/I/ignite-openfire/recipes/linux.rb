include_recipe 'chef-sugar'

version = node['openfire']['version'].to_s
version_windows = version.tr('.', '_')

case node['platform_family']
when 'rhel', 'suse'
  source_file = "openfire/openfire-#{version}-1.i386.rpm"
  local_package_path = "#{Chef::Config['file_cache_path']}/openfire.rpm"
  platform_checksum = node['openfire']['checksum'][version]['rpm']
when 'debian'
  source_file = "openfire/openfire_#{version}_all.deb"
  local_package_path = "#{Chef::Config['file_cache_path']}/openfire.deb"
  platform_checksum = node['openfire']['checksum'][version]['deb']
when 'windows'
  source_file = "openfire/openfire_#{version_windows}.exe"
  local_package_path = "#{Chef::Config['file_cache_path']}/openfire.exe"
  platform_checksum = node['openfire']['checksum'][version]['exe']
end

remote_file local_package_path do
  checksum platform_checksum
  source "http://www.igniterealtime.org/downloadServlet?filename=#{source_file}"
end

directory node['openfire']['log_dir'] do
  user 'daemon'
  group 'daemon'
  recursive true
end

if ubuntu?
  include_recipe 'apt'
  package 'default-jre-headless'
end

include_recipe 'java' if rhel?

package 'openfire' do
  provider Chef::Provider::Package::Dpkg if debian?
  source local_package_path
  notifies :restart, 'service[openfire]', :delayed
end

template '/etc/sysconfig/openfire' do
  mode '0644'
  source 'openfire.erb'
  variables(
    user: node['openfire']['user'],
    pid_file: '/var/run/openfire.pid',
    home_dir: node['openfire']['home_dir'],
    log_dir: node['openfire']['log_dir'],
    java_home: node['java']['java_home']
  )
end

template '/opt/openfire/conf/openfire.xml' do
  mode '0644'
  source 'openfire.xml.erb'
  variables(
    admin_port: node['openfire']['config']['admin_port'],
    admin_port_secure: node['openfire']['config']['secure_port'],
    locale: node['openfire']['config']['locale'],
    network_interface: node['openfire']['config']['network_interface'],
    external_db: node['openfire']['config']['database']['type'],
    db_driver: node['openfire']['config']['database']['driver'],
    db_connection: node['openfire']['config']['database']['connection'],
    db_user: node['openfire']['config']['database']['user'],
    db_password: node['openfire']['config']['database']['password']
  )
end

service 'openfire' do
  action :start
end
