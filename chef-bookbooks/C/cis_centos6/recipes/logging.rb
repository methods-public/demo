# 5.1.1 Install the rsyslog package
package 'rsyslog'

# 5.1.2 Activate the rsyslog Service
service 'syslog' do
	action [:stop, :disable]
end

service 'rsyslog' do
	action [:enable, :start]
end

# 5.1.3 Configure /etc/rsyslog.conf
template '/etc/rsyslog.conf' do
	source 'etc/rsyslog.conf.erb'
	owner 'root'
	group 'root'
	mode 0644
	notifies :reload, 'service[rsyslog]', :immediately
end

# 5.1.4 Create and Set Permissions on rsyslog Log Files
# Following files are mentioned in /etc/rsyslog.conf:
# /var/log/boot.log
# /var/log/cron
# /var/log/maillog
# /var/log/messages
# /var/log/secure
# /var/log/spooler
[
	'boot.log',
	'cron',
	'daemon.log',
	'kern.log',
	'maillog',
	'messages',
	'secure',
	'spooler',
	'syslog',
	'unused.log'
].each do |f|
	file "/var/log/#{f}" do
		owner 'root'
		group 'root'
		mode 0600
	end
end

# 5.2.1.1 Configure Audit Log Storage Size 
# 5.2.1.2 Disable System on Audit Log Full
# 5.2.1.3 Keep All Auditing Information
template '/etc/audit/auditd.conf' do
	source 'etc/audit/auditd.conf.erb'
	owner 'root'
	group 'root'
	mode 0640
	variables({
		:max_log_size => node['cis_centos6']['logging']['auditd']['max_log_size'],
		:disable_system_on_audit_log_full => node['cis_centos6']['logging']['auditd']['disable_system_on_audit_log_full']
	})
	notifies :reload, 'service[auditd]', :immediately
end

# 5.2.2 Enable auditd Service
service 'auditd' do
	action [:enable, :start]
end

# 5.2.3 Enable auditing for processes that start prior to auditd
execute 'Enable auditing for processes that start prior to auditd' do
	command 'sed -e \'s/ audit=1//g\' -e \'/^[^#]*kernel/s/$/ audit=1/\' -i /etc/grub.conf'
	only_if 'grep "^[^#]*kernel" /etc/grub.conf | grep -v "audit=1"'
end

# 5.2.4 Record events that modify date and time information
# 5.2.5 Record Events That Modify User/Group Information
# 5.2.6 Record Events That Modify the System's Network Environment
# 5.2.7 Record Events That Modify the System's Mandatory Access Controls
# 5.2.8 Collect Login and Logout Events
# 5.2.9 Collect Session Initiation Information
# 5.2.10 Collect Discretionary Access Control Permission Modification Events
# 5.2.11 Collect Unsuccessful Unauthorized Access Attempts to Files
# 5.2.12 Collect Use of Privileged Commands
# 5.2.13 Collect Successful File System Mounts
# 5.2.14 Collect File Deletion Events by User
# 5.2.15 Collect Changes to System Administration Scope
# 5.2.16 Collect System Administrator Actions (sudolog)
# 5.2.17 Collect Kernel Module Loading and Unloading
# 5.2.18 Make the Audit Configuration Immutable
template '/etc/audit/audit.rules' do
	source 'etc/audit/audit.rules.erb'
	variables({
		:privileged_commands => PrivilegedCommands.getCommands()
	})
	owner 'root'
	group 'root'
	mode 0640
	notifies :reload, 'service[auditd]'
end

# 5.3 Configure logrotate
template '/etc/logrotate.d/syslog' do
	source 'etc/logrotate.d/syslog'
	owner 'root'
	group 'root'
	mode 0644
end
