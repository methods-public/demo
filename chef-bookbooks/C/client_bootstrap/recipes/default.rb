#
# Cookbook Name:: client_bootstrap
# Recipe:: default
#
# Copyright (c) 2016-2017 The Authors, All Rights Reserved.

dab_bootstrap = data_bag('bootstrap')

dab_sources = data_bag_item('sources','bootstraping')

dab_bootstrap.each do |str_hostname|
dab_hosts = data_bag_item('bootstrap', str_hostname)

case #{dab_hosts['platform']}
when 'windows'
bash 'windows_bootstrap' do
	 cwd '/etc/chef'
		 code <<-EOH
		sudo knife bootstrap windows winrm #{dab_hosts['fqdn']} -N #{dab_hosts ['hostname']} -E #{dab_hosts['environment']} --winrm-user #{dab_hosts['user']}@#{dab_hosts['domain']} --winrm-password #{dab_hosts['passwd']} --msi-url #{dab_sources['win']} -r 'role[first_run]'
		 EOH
	 end
	 dab_hosts['bootstraped'] = 'true'
	 dab_hosts.save
when 'redhat', 'centos', 'fedora'
	 bash 'chef_bootstrap' do
	 cwd '/etc/chef'
		 code <<-EOH
		 sudo knife bootstrap #{dab_hosts['fqdn']} -x #{dab_hosts['user']} -P #{dab_hosts['passwd']} -N #{dab_hosts ['hostname']} --bootstrap-install-command "yum --nogpgcheck install -y #{dab_sources['rhel']} | sudo bash -s --" --sudo
		 EOH
	 end 
	 dab_hosts['bootstraped'] = 'true'
	 dab_hosts.save
end
end
