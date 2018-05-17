#
## Cookbook Name:: configure_and_deploy_ssc
## Recipe:: rhel_install_mysql
##
## Copyright (c) 2016 The Authors, All Rights Reserved.
#
#
mysql_service node['mysql']['instance_name'] do
  port node['mysql']['port']
  version node['mysql']['install_version']
  initial_root_password node['mysql']['server_root_password']
  #action [:create, :start]
  action [:create]
end


# Configure memory for MySQL by updating the my.ini (for Unix like environments, it will be my.cnf)
# Stop the MySQL Service

#service "#{node['mysql']['service_name']}" do
#  action [:stop]
#end


# Write the config file my.ini
template "/etc/#{node['mysql']['service_name']}/my.cnf" do
  variables({
    :service_name => node['mysql']['service_name'],
    :port => node['mysql']['port']
  })
  source 'my.cnf.erb'
end

# Creating the SELinux security context mapping
bash "Creating SELinux mysqld_db_t mapping to #{node['mysql']['service_name']} instance directory" do
  user "root"
  action :run
  code <<-EOH
semanage fcontext -a -t mysqld_db_t "/var/lib/#{node['mysql']['service_name']}(/.*)?"
EOH
end

# Applying/restoring SElinux mappings to Fortify SSC's mysql instance
bash "Applying/Restoring SELinux mappings to #{node['mysql']['service_name']} instance directory" do
  user "root"
  action :run
  code <<-EOH
restorecon -R -v "/var/lib/#{node['mysql']['service_name']}"
EOH
end


mysql_service node['mysql']['instance_name'] do 
  action [:start]
end
