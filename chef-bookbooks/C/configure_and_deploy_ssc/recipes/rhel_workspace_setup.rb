#
# Cookbook Name:: configure_and_deploy_ssc
# Recipe:: rhel_workspace_setup
#
# This recipe will create the temporary workspace and download the needed files 
# that the rest of this coobook will use to configure the SSC war file and DB.

# Clean up artifacts of previous run by deleting the working directory recursively
directory node['configure_ssc']['working_dir'] do
  action :delete
  recursive true
  only_if {Dir.exist?("#{node['configure_ssc']['working_dir']}")}
end

# Build a working directory
directory node['configure_ssc']['working_dir'] do
  action :create
end

include_recipe 'configure_and_deploy_ssc::rhel_download_ssc_files'

# Unzips the SSC configuration tools and files
zipfile "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['ssc_package_name']}" do
  into "#{node['configure_ssc']['working_dir']}"
  action :extract
end

