# 6.2.3 Set Permissions on /etc/ssh/sshd_config
template '/etc/ssh/sshd_config' do
	source 'etc/ssh/sshd_config.erb'
	owner 'root'
	group 'root'
	mode 0600
	notifies :reload, 'service[sshd]'
    variables({
        :allow_users => node['cis_centos6']['sshd_config']['allow_users'],
        :allow_groups => node['cis_centos6']['sshd_config']['allow_groups'],
        :deny_users => node['cis_centos6']['sshd_config']['deny_users'],
        :deny_groups => node['cis_centos6']['sshd_config']['deny_groups'],
        :ciphers => node['cis_centos6']['sshd_config']['ciphers'],
        :macs => node['cis_centos6']['sshd_config']['macs']
    })

end

service 'sshd' do
	action [:enable, :start]
end
