#
# Cookbook Name:: configure_and_deploy_ssc
# Recipe:: rhel
#

# This is essentially a parent/wrapper recipe that will kick off the other 
# needed recipes to automatically create the a running SSC instance. 
# Aside from that, the only other thing this recipe does id check for the 
# existence of the ssc war file in the <tomcat>/webapps directory and
# if it exists, then bail out as this isn't an upgrade script, simply an
# installation script.

#TODO:
#  - Add feature for upgrading an existing ssc instance (provided it was created using an older version of this cookbook)
#  - Add recipe to add needed firewall and SELinux policy exceptions
#  --	firewall-cmd --permanent --add-port=8080/tcp && systemctl reload firewalld.service
#  - Have all dependencies handled by Berkshelf
#  - Add logic to handle for the recipe to use ssc installation files that already exist on the local file system.

# Quick check for existing 
ruby_block 'check_for_ssc_war' do
  block do
    if File.file?("#{node['tomcat']['install_dir']}/webapps/ssc.war")
      raise "Fortify SSC has already been installed on this machine"
    end
  end
end
# Installing prerequisite software
include_recipe 'configure_and_deploy_ssc::rhel_install_java'
include_recipe 'configure_and_deploy_ssc::rhel_install_tomcat8'
include_recipe 'configure_and_deploy_ssc::rhel_install_mysql'

# Configure and deploy ssc
include_recipe 'configure_and_deploy_ssc::rhel_workspace_setup'
include_recipe 'configure_and_deploy_ssc::rhel_create_db'
include_recipe 'configure_and_deploy_ssc::rhel_configure_war'
include_recipe 'configure_and_deploy_ssc::rhel_seed_db'
include_recipe 'configure_and_deploy_ssc::rhel_deploy_ssc_war'

# Apply additional security settings
include_recipe 'configure_and_deploy_ssc::rhel_node_security_settings'
