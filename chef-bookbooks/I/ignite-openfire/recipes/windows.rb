node.default['openfire']['base_dir'] = 'C:\Program Files (x86)\Openfire'
node.default['openfire']['home_dir'] = (node['openfire']['base_dir']).to_s
node.default['openfire']['log_dir']  = "#{node['openfire']['base_dir']}\logs"

version = node['openfire']['version'].to_s
version_windows = version.tr('.', '_')

source_file = "openfire/openfire_#{version_windows}.exe"
local_package_path = "#{Chef::Config['file_cache_path']}/openfire.exe"
platform_checksum = node['openfire']['checksum'][version]['exe']

remote_file local_package_path do
  checksum platform_checksum
  source "http://www.igniterealtime.org/downloadServlet?filename=#{source_file}"
end

service 'Openfire'

windows_package 'openfire' do
  source local_package_path
  installer_type :custom
  options '-q'
  notifies :restart, 'service[Openfire]', :delayed
end

batch 'install openfire service' do
  cwd "#{node['openfire']['base_dir']}/bin"
  code <<-EOH
    openfire-service.exe /install
    EOH
  notifies :start, 'service[Openfire]', :delayed
end
