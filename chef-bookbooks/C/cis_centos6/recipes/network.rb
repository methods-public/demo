# 4.4.2 Disable IPv6
template '/etc/modprobe.d/ipv6.conf' do
	source 'etc/modprobe.d/ipv6.conf.erb'
	owner 'root'
	group 'root'
	mode 0644
end

ruby_block 'Disable NETWORKING_IPV6 in /etc/sysconfig/network' do
	block do
		file = Chef::Util::FileEdit.new('/etc/sysconfig/network')
		file.search_file_replace_line(/[\\s]*NETWORKING_IPV6/, 'NETWORKING_IPV6=no')
		file.insert_line_if_no_match(/[\\s]*NETWORKING_IPV6/, 'NETWORKING_IPV6=no')
		file.write_file
	end
	not_if 'grep "[\\s]*NETWORKING_IPV6=no" /etc/sysconfig/network'
end

ruby_block 'Disable IPV6INIT in /etc/sysconfig/network' do
	block do
		file = Chef::Util::FileEdit.new('/etc/sysconfig/network')
		file.search_file_replace_line(/[\\s]*IPV6INIT/, 'IPV6INIT=no')
		file.insert_line_if_no_match(/[\\s]*IPV6INIT/, 'IPV6INIT=no')
		file.write_file
	end
	not_if 'grep "[\\s]*IPV6INIT=no" /etc/sysconfig/network'
end

execute 'Remove IPv6 localhost address from /etc/hosts' do
	command 'sed "/::1/d" -i /etc/hosts'
	only_if 'grep "::1" /etc/hosts'
end

# 4.5.1 Install TCP Wrappers
package 'tcp_wrappers'

# 4.5.2 Create /etc/hosts.allow
# 4.5.3 Verify Permissions on /etc/hosts.allow
# 4.5.4 Create /etc/hosts.deny
# 4.5.5 Verify Permissions on /etc/hosts.allow
['hosts.allow', 'hosts.deny'].each do |f|
	file "/etc/#{f}" do
		owner 'root'
		group 'root'
		mode 0644
	end
end

# 4.7 Enable IPtables
# Have to ensure this iptables file exists first: https://bugs.launchpad.net/packstack/+bug/1305256
file '/etc/sysconfig/iptables' do
	owner 'root'
	group 'root'
	mode 0644
end

service 'iptables' do
	action [:enable, :start]
end
