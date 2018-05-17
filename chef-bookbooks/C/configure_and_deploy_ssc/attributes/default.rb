#
# Cookbook Name:: configure_and_deploy_ssc
# Recipe:: default
# 

# Java installation attributes
default['java']['jdk_version'] = '8'
default['java']['oracle']['accept_oracle_download_terms'] = false # You NEED to set this to true. The default is set to false due to licensing concerns.
default['java']['set_default'] = true

# Variables
default['configure_ssc']['war_configurator_dir'] = "HPE-Security-Fortify-Server-WAR"
default['configure_ssc']['fortify_license_file_name'] = 'fortify.license'

default['mysql']['instance_name'] = 'fortify_ssc'
default['mysql']['service_name'] = "mysql-#{node['mysql']['instance_name']}"
default['mysql']['server_root_password'] = "123!@#qweQWE"
default['mysql']['port'] = '3306'
default['mysql']['version'] = '5.6' # This will controll what version of mysql gets installed. Unfortunately there's a bug and only 5.5.X is getting installed.
default['mysql']['default_mysql_collation'] = "latin1_general_cs"
default['mysql']['buffer_pool_size'] = "128M" # Try to keep at >= 512M if possible. If running on low memory you can set to something lower like 128M

default['mysql']['install_dir'] = '/usr/local/mysql'
default['mysql']['ssc_database_name'] = 'ssc'
default['mysql']['ssc_database_user'] = 'sscuser'
default['mysql']['ssc_database_user_password'] = 'ssc_userpassword'
default['mysql']['ssc_database_host'] = 'localhost'
default['mysql']['db_connection_string'] = "jdbc\:mysql\://localhost\:3306/ssc?connectionCollation=#{node['mysql']['default_mysql_collation']}"
default['mysql']['db_driver'] = 'com.mysql.jdbc.Driver'
default['mysql']['db_dialect'] = 'com.fortify.manager.util.hibernate.MySQLDialect'
default['mysql']['db_driver_jars'] = 'mysql-connector-java-5.1.38-bin.jar'
default['mysql']['db_like_specialchars'] = '%_\\'
default['mysql']['dir'] = "/usr/local/mysql"

# Right now next 6 tomcat attributes are really only used by the tomcat8 install recipe
default['tomcat']['instance_name'] = "tomcat_fortify_ssc"
default['tomcat']['install_dir'] = "/var/tomcat8"
default['tomcat']['Xmx'] = '2048M'
default['tomcat']['Xms'] = '512M'
default['tomcat']['service_user'] = "root"
default['tomcat']['service_group'] = "root"

default['fortify_ssc']['app_server'] = 'appserver.tomcat'
default['fortify_ssc']['host_url'] = 'http://localhost:8080/ssc'

# LDAP Settings
# Not yet...
default['ldap']['base_dn'] = ''

# Package Names
default['configure_ssc']['ssc_package_name'] = 'HPE_Security_Fortify_SSC_16.11_Server_WAR.zip'
default['configure_ssc']['pci_bundle_name'] = 'HP_Fortify_PCI_Basic_Seed_Bundle_2016_Q3.zip'
default['configure_ssc']['reports_bundle_name'] = 'HP_Fortify_Report_Seed_Bundle_2016_Q3.zip'
default['configure_ssc']['process_bundle_name'] = 'HP_Fortify_Process_Seed_Bundle_2016_Q3.zip'
default['configure_ssc']['jdbc_driver_name'] = 'mysql-connector-java-5.1.38-bin.jar'

# Configuration
default['seed_pci_bundle'] = false
default['seed_reports_bundle'] = true
default['seed_process_bundle'] = true
default['harden_tomcat'] = true

# Directories
default['configure_ssc']['working_dir'] = "/var/SSCConfigurator/"
#default['configure_ssc']['apache_dir'] = "C:/Program Files/Apache Software Foundation/"
#default['configure_ssc']['tomcat_dir'] = "#{['configure_ssc']['apache_dir']}Tomcat 8.5/"
default['configure_ssc']['ssc_index_dir'] = "/tmp/ssc_search_index/"

# Resource Urls
default['configure_ssc']['resource_url'] = 'http://chef-server1:8081/sscfiles/'
default['configure_ssc']['ssc_url'] = "#{default['configure_ssc']['resource_url']}#{node['configure_ssc']['ssc_package_name']}"
default['configure_ssc']['pci_bundle_url'] = "#{default['configure_ssc']['resource_url']}#{node['configure_ssc']['pci_bundle_name']}"
default['configure_ssc']['jdbc_driver_url'] = "#{default['configure_ssc']['resource_url']}#{node['configure_ssc']['jdbc_driver_name']}"
default['configure_ssc']['reports_bundle_url'] = "#{default['configure_ssc']['resource_url']}#{node['configure_ssc']['reports_bundle_name']}"
default['configure_ssc']['process_bundle_url'] = "#{default['configure_ssc']['resource_url']}#{node['configure_ssc']['process_bundle_name']}"
