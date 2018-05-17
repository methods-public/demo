#
## Cookbook Name:: configure_and_deploy_ssc
## Recipe:: rhel_install_tomcat8
##
## Copyright (c) 2016 The Authors, All Rights Reserved.
#

# Installs Apache Tomcat 8. 
# At the moment this recipe is pretty much empty, but there could be a situation where
# the Tomcat installation needs to be modified or the currently used cookbook relied upon
# is replaced by a differet one. This helps to keep things a little more modular


tomcat_install 'fortify_ssc' do
  version '8.0.36'
  install_path '/var/tomcat8'
end

tomcat_service 'fortify_ssc' do
  action [:enable]
  env_vars [ {'CATALINA_BASE' => '/var/tomcat8/'}, 
	     {'CATALINA_PID' => '$CATALINA_BASE/bin/tomcat.pid'},
	     {'JAVA_HOME' => '/usr/lib/jvm/java-1.8.0'}
 	   ]
end

template "/etc/systemd/system/#{node['tomcat']['instance_name']}.service" do
  source 'tomcat_systemd_unit_file.service.erb'
  # node['tomcat']['instance_name']
  variables({
    :instance_name => node['tomcat']['instance_name'],
    :install_dir => node['tomcat']['install_dir'],
    :Xmx => node['tomcat']['Xmx'],
    :Xms => node['tomcat']['Xms'],
    :service_user => node['tomcat']['service_user'],
    :service_group => node['tomcat']['service_group']
  })
end

bash 'Reload systemd unit files - systemctl daemon-reload' do
  user "root"
  action :run
  code <<-EOH
systemctl daemon-reload
EOH
end

service "#{node['tomcat']['instance_name']}" do 
  action :restart
end
