#
## Cookbook Name:: configure_and_deploy_ssc
## Recipe:: rhel_node_security_settings
##
## Copyright (c) 2016 The Authors, All Rights Reserved.
#

# Changes and creates various security related settings for the given node.
# Examples would be firewall, SELinux, and file/directory permissions

# Add firewall exception for tomcat8
bash 'add_tomcat8_firewall_exception' do
  code <<-EOH
firewall-cmd --permanent --add-port=8080/tcp 
  EOH
end

# After updating firewall settings, need to reload the firewalld service
service 'firewalld' do
 action :restart
end
