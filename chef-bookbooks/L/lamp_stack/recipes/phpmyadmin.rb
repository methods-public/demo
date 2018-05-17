#Download EPEL repository

execute 'download epel repo' do
	cwd 'root'
	command 'wget http://epel.mirror.net.in/epel/6/i386/epel-release-6-8.noarch.rpm'
end

#get the packages to repo

execute 'apply rpm' do
	cwd 'root'
	command 'rpm -Uvh epel-release-6-8.noarch.rpm'
end

#install PHPMYADMIN

execute 'install phpmyadmin' do
	cwd 'root'
	command 'sudo yum install phpmyadmin -y'
end

#add the template file to allow access

if node['platform'] == 'redhat' || node['platform'] == 'centos'
	if node['platform_version'].to_f >= 7.0
		template '/etc/httpd/conf.d/phpMyAdmin.conf' do
			source 'phpMyAdmin7.conf.erb'
			owner 'root'
			group 'root'
			mode '0644'
		end
	else
	    template '/etc/httpd/conf.d/phpMyAdmin.conf' do
			source 'phpMyAdmin.conf.erb'
			owner 'root'
			group 'root'
			mode '0644'
		end
	end	 	
end
