#
# Cookbook Name:: configure_and_deploy_ssc
# Recipe:: rhel_configure_war
#
#
# This recipe will configure the ssc.war file. 
# This recipe relies on the rhel_workspace_setup recipe having already executed

# Write out the license file. May consider downloading the license file rather than store it as a template.
template "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['fortify_license_file_name']}" do
  source 'fortify.license.erb'
end

# Write out the property files
template "#{node['configure_ssc']['working_dir']}dataSource.properties" do
  variables({
    :db_connection_string => node['mysql']['db_connection_string'],
    :jdbc_driver_jars => node['mysql']['db_driver_jars'],
    :ssc_database_user  => node['mysql']['ssc_database_user'],
    :ssc_database_user_password  => node['mysql']['ssc_database_user_password'],
    :driver_class  => node['mysql']['db_driver'],
    :db_dialect => node['mysql']['db_dialect'],
    :db_like_specialchars => node['mysql']['db_like_specialchars']
  })
  source 'dataSource.properties.erb'
end

template "#{node['configure_ssc']['working_dir']}ldap.properties" do
  source 'ldap.properties.erb'
end

directory node['configure_ssc']['ssc_index_dir'] do
  owner 'mysql'
  group 'mysql'
  mode '0755'
  action :create
end

template "#{node['configure_ssc']['working_dir']}ssc.properties" do
  variables({
    :host_url => node['fortify_ssc']['host_url'],
    :app_server => node['fortify_ssc']['app_server'], # Tomcat, websphere, jboss, etc...
    :ssc_index_dir  => node['configure_ssc']['ssc_index_dir']
  })
  source 'ssc.properties.erb'
end


# Programatically configure the war file.
# Command: java -jar ssc-configuration-wizard.jar -automationMode -war ssc.war -jdbcDriver ..\mysql-connector-java-5.1.26-bin.jar -license ..\fortify.license -loadfrom ..\dataSource.properties -loadfrom ..\ssc.properties
# Currently executes successfully but exits with ...
#   "STDERR: Java HotSpot(TM) 64-Bit Server VM warning: ignoring option MaxPermSize=128M; support was removed in 8.0"
# Which causes Chef to fail, so had to add "ignore_failure true"
bash "Configure war file" do
  user "root"
  action :run
  code <<-EOH
    java -jar \
    "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['war_configurator_dir']}/ssc-configuration-wizard.jar" \
    -automationMode \
    -war "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['war_configurator_dir']}/ssc.war" \
    -jdbcDriver "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['jdbc_driver_name']}" \
    -license "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['fortify_license_file_name']}" \
    -loadfrom "#{node['configure_ssc']['working_dir']}dataSource.properties" \
    -loadfrom "#{node['configure_ssc']['working_dir']}ssc.properties"
  EOH
  ignore_failure true
end
