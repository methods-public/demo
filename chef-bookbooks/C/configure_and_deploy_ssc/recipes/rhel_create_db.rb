#
# Cookbook Name:: configure_and_deploy_ssc
# Recipe:: rhel_create_db
#

# This recipe creates a new DB that SSC will ultimately use
# This recipe relies on rhel_workspace_setup having already executed

# Start the MySQL Service if it isn't already running
#service "#{node['mysql']['service_name']}" do
#  action [:start]
#end

# Create the database...
# DB Create Command:  &cmd.exe /c mysql.exe -u root -e "create database if not exists ssc CHARACTER SET latin1 COLLATE latin1_general_cs; GRANT ALL PRIVILEGES ON ssc.* TO sscuser@localhost IDENTIFIED BY 'ssc_userpassword'"
bash "Create Database" do
  user "root"
  code <<-EOL
    mysql --socket "/var/run/#{node['mysql']['service_name']}/mysqld.sock" -u root --password='#{node['mysql']['server_root_password']}' -e "create database if not exists #{node['mysql']['ssc_database_name']} CHARACTER SET latin1 COLLATE #{node['mysql']['default_mysql_collation']}; GRANT ALL PRIVILEGES ON #{node['mysql']['ssc_database_name']}.* TO #{node['mysql']['ssc_database_user']}@#{node['mysql']['ssc_database_host']} IDENTIFIED BY '#{node['mysql']['ssc_database_user_password']}'"
  EOL
  action :run
end

# Run the MySQL Table Creation script.
# Run script command: &cmd.exe /c "mysql.exe -u root ssc < C:\SSCConfigurator\HPE-Security-Fortify-Server-WAR\sql\mysql\create-tables.sql"
bash "running creation script" do
  user "root"
  action :run
  mypass = "'" + node['mysql']['server_root_password'] + "'"
  code <<-EOH
    mysql --socket "/var/run/#{node['mysql']['service_name']}/mysqld.sock" -u root --password='#{node['mysql']['server_root_password']}' #{node['mysql']['ssc_database_name']} < "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['war_configurator_dir']}/sql/mysql/create-tables.sql"
  EOH
end
