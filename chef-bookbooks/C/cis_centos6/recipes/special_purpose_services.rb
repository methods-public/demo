# 3.2 Remove X Windows
execute 'Remove X Windows' do
	command 'yum groupremove "X Window System"'
	only_if 'yum grouplist "X Window System" | grep Installed'
end

template '/etc/inittab' do
	source 'etc/inittab.erb'
	owner 'root'
	group 'root'
	mode 0644
end

# 3.5 Remove DHCP Server
# 3.7 Remove LDAP
# 3.9 Remove DNS Server
# 3.10 Remove FTP Server
# 3.11 Remove HTTP Server
# 3.12 Remove Dovecot
# 3.13 Remove Samba
# 3.14 Remove HTTP Proxy Server
# 3.15 Remove SNMP Server
[
	'dhcp',
	'openldap-servers',
	'openldap-clients',
	'bind',
	'vsftpd',
	'httpd',
	'dovecot',
	'samba',
	'squid',
	'net-snmp'
].each do |p|
	package p do
		action :remove
	end
end

# 3.3 Disable Avahi Server
# 3.4 Disable Print Server - CUPS
[
	'avahi-daemon',
	'cups'
].each do |s|
	service s do
		action [:stop, :disable]
	end
end

if node['cis_centos6']['special_purpose_services']['disable_nfs_and_rpc']
	# 3.8 Disable NFS and RPC
	[
		'nfslock',
		'rpcgssd',
		'rpcbind',
		'rpcidmapd',
		'rpcsvcgssd'
	].each do |s|
		service s do
			action [:stop, :disable]
		end
	end
end

# 3.6 Configure Network Time Protocol
package 'ntp'

service 'ntpd' do
	action [:enable, :start]
end

template '/etc/ntp.conf' do
	source 'etc/ntp.conf.erb'
	owner 'root'
	group 'root'
	mode 0644
	variables :servers => node['cis_centos6']['special_purpose_services']['ntp']['servers']
	notifies :restart, 'service[ntpd]', :immediately
end

# 3.16 Configure Mail Transfer Agent for Local-Only Mode
template '/etc/postfix/main.cf' do
	source 'etc/postfix/main.cf.erb'
	owner 'root'
	group 'root'
	mode 0644
	notifies :reload, 'service[postfix]', :immediately
end

service 'postfix' do
	action [:nothing]
end
