#
# Cookbook Name:: configure_and_deploy_ssc
# Recipe:: rhel_download_ssc_files
#
# This recipe will download the needed SSC install files from a remote resource (eg: http(s), (s)ftp.)

# Download the necessary files.
# SSC Configurator
remote_file "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['ssc_package_name']}" do
  source "#{node['configure_ssc']['ssc_url']}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Download JDBC Driver
remote_file "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['jdbc_driver_name']}" do
  source "#{node['configure_ssc']['jdbc_driver_url']}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Get the seed bundles
remote_file "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['pci_bundle_name']}" do
  only_if { node['seed_pci_bundle'] == true }
  source "#{node['configure_ssc']['pci_bundle_url']}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['reports_bundle_name']}" do
  only_if { node['seed_reports_bundle'] == true }
  source "#{node['configure_ssc']['reports_bundle_url']}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['process_bundle_name']}" do
  only_if { node['seed_process_bundle'] == true }
  source "#{node['configure_ssc']['process_bundle_url']}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
