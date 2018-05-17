# 1.2.2 Verify that gpgcheck is Globally Activated
template '/etc/yum.conf' do
	source 'etc/yum.conf.erb'
	owner 'root'
	group 'root'
	mode 0644
	variables({
		:exclude => node['cis_centos6']['additional_security']['yum']['exclude']
	})
end

# 1.3.1 Install AIDE
package 'aide'
execute 'initialise aide' do
	command '/usr/sbin/aide --init -B \'database_out=file:/var/lib/aide/aide.db.gz\''
	not_if { File.exists?('/var/lib/aide/aide.db.gz') }
end

# 1.3.2 Implement Periodic Execution of File Integrity
cron 'aide' do
	minute '0'
	hour '5'
	command '/usr/sbin/aide --check'
end

# 1.4.1 Enable SELinux in /etc/grub.conf
execute 'Enable SELinux in /etc/grub.conf' do
	command 'sed -e \'s/selinux=0//g\' -e \'s/enforcing=0//g\' -i /etc/grub.conf'
	only_if { node['cis_centos6']['additional_security']['selinux']['enabled'] }
	only_if 'grep "selinux=0\\|enforcing=0" /etc/grub.conf'
end

# 1.4.2 Set the SELinux State
# 1.4.3 Set the SELinux Policy
template '/etc/selinux/config' do
	source 'etc/selinux/config.erb'
	owner 'root'
	group 'root'
	mode 0644
	variables({
		:state => (node['cis_centos6']['additional_security']['selinux']['enabled'] ? 'enforcing' : 'disabled')
	})
end

# 1.4.4 Remove SETroubleshoot
# 1.4.5 Remove MCS Translation Service (mcstrans)
['mcstrans', 'setroubleshoot'].each do |p|
	package p do
		action :remove
	end
end

# 1.5.1 Set User/Group Owner on /etc/grub.conf
# 1.5.2 Set Permissions on /etc/grub.conf
# /etc/grub.conf symlinked to /boot/grub/grub.conf
file '/boot/grub/grub.conf' do
	owner 'root'
	group 'root'
	mode 0600
end

# 1.6.1 Restrict Core Dumps
template '/etc/security/limits.conf' do
	source 'etc/security/limits.conf.erb'
	owner 'root'
	group 'root'
	mode 0644
end
