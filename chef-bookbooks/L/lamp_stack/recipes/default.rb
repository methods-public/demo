#
# Cookbook Name:: lamp_stack
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
if node['platform'] == 'redhat' || node['platform'] == 'centos'
	if node['platform_version'].to_f >= 7.0
		service_name = 'mariadb'
	else
	    service_name = 'mysqld'
	end
end	    	



include_recipe "lamp_stack::apacheHttpd"

#install mysql files.

case node['platform']
when 'redhat', 'centos'
	if node['platform_version'].to_f >= 7.0
		%w{mariadb-server mariadb}.each do |soft|
			execute "sudo yum install #{soft} -y"
		end
	else
		%w{mysql mysql-server}.each do |soft|
			execute "sudo yum install #{soft} -y"
		end	
	end	
end

#enable mysqld or mariadb service

service service_name do
	action [:enable, :start]
end



bash 'mysql_secure_install_automate' do
user 'root'
cwd 'root'
code <<-EOH
mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('abcd1234') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
EOF
EOH
end

#restart the mysqld or mariadb service

service service_name do
	action :restart
end

#install php modules

%w{php php-mysql php-common php-gd php-imap php-curl}.each do |mod|
	execute "sudo yum install #{mod} -y"
end

include_recipe "lamp_stack::phpmyadmin"

service "httpd" do
	action :restart
end

service service_name do
	action :restart
end

#enable httpd on restart
execute "chkconfig httpd on"

#enable mysqld service on restart

execute "chkconfig #{service_name} on"
