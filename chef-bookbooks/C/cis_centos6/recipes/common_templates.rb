# Templates for configurations that need to write into the same file

template '/etc/modprobe.d/CIS.conf' do
	source 'etc/modprobe.d/cis.erb'
	owner 'root'
	group 'root'
	mode 0644
	variables :partials => {
		# 1.1.18 Disable Mounting of cramfs Filesystems
		# 1.1.19 Disable Mounting of freevxfs Filesystems
		# 1.1.20 Disable Mounting of jffs2 Filesystems
		# 1.1.21 Disable Mounting of hfs Filesystems
		# 1.1.22 Disable Mounting of hfsplus Filesystems
		# 1.1.23 Disable Mounting of squashfs Filesystems
		# 1.1.24 Disable Mounting of udf Filesystems
		'etc/modprobe.d/cis_additional_security.erb' => node['recipes'].include?('cis_centos6::additional_security'),
		# 4.6.1 Disable DCCP (Datagram Congestion Control Protocol)
		# 4.6.2 Disable SCTP (Stream Control Transmission Protocol)
		# 4.6.3 Disable RDS (Reliable Datagram Sockets)
		# 4.6.4 Disable TIPC (Transparent Inter-Process Communication)
		'etc/modprobe.d/cis_network.erb' => node['recipes'].include?('cis_centos6::network')
	}
end

template '/etc/sysconfig/init' do
	source 'etc/sysconfig/init.erb'
	owner 'root'
	group 'root'
	mode 0644
	variables :partials => {
		# 1.5.4 Require Authentication for Single-User Mode
		# 1.5.5 Disable Interactive Boot
		'etc/sysconfig/init_additional_security.erb' => node['recipes'].include?('cis_centos6::additional_security'),
		# 3.1 Set Daemon umask
		'etc/sysconfig/init_special_purpose_services.erb' => node['recipes'].include?('cis_centos6::special_purpose_services')
	}
end
