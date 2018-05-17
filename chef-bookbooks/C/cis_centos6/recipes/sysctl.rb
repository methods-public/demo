sysctl_values = {
	# 1.6.1 Restrict Core Dumps
	'fs.suid_dumpable' => 0,

	# 1.6.2 Configure ExecShield
	'kernel.exec-shield' => 1,

	# 1.6.3 Enable Randomized Virtual Memory Region Placement
	'kernel.randomize_va_space' => 2,

	# 4.1.1 Disable IP Forwarding
	'net.ipv4.ip_forward' => 0,

	# 4.1.2 Disable Send Packet Redirects
	'net.ipv4.conf.all.send_redirects' => 0,
	'net.ipv4.conf.default.send_redirects' => 0,

	# 4.2.1 Disable Source Routed Packet Acceptance
	'net.ipv4.conf.all.accept_source_route' => 0,
	'net.ipv4.conf.default.accept_source_route' => 0,

	# 4.2.2 Disable ICMP Redirect Acceptance
	'net.ipv4.conf.all.accept_redirects' => 0,
	'net.ipv4.conf.default.accept_redirects' => 0,

	# 4.2.3 Disable Secure ICMP Redirect
	'net.ipv4.conf.all.secure_redirects' => 0,
	'net.ipv4.conf.default.secure_redirects' => 0,

	# 4.2.4 Log Suspicious Packets
	'net.ipv4.conf.all.log_martians' => 1,
	'net.ipv4.conf.default.log_martians' => 1,

	# 4.2.5 Enable Ignore Broadcast Requests
	'net.ipv4.icmp_echo_ignore_broadcasts' => 1,

	# 4.2.6 Enable Bad Error Message Protection
	'net.ipv4.icmp_ignore_bogus_error_responses' => 1,

	# 4.2.7 Enable RFC-recommended Source Route Validation
	'net.ipv4.conf.all.rp_filter' => 1,
	'net.ipv4.conf.default.rp_filter' => 1,

	# 4.2.8 Enable TCP SYN Cookies
	'net.ipv4.tcp_syncookies' => 1,
}

# these keys are only accessible if the ipv6 module has been loaded without the disabled parameter flags
if !Ipv6ModuleDisabledDetector.checkModuleIsDisabled()

	# 4.4.1.1 Disable IPv6 Router Advertisements
	sysctl_values['net.ipv6.conf.all.accept_ra'] = 0
	sysctl_values['net.ipv6.conf.default.accept_ra'] = 0

	# 4.4.1.2 Disable IPv6 Redirect Acceptance
	sysctl_values['net.ipv6.conf.all.accept_redirects'] = 0
	sysctl_values['net.ipv6.conf.default.accept_redirects'] = 0

	# 4.4.2 Disable IPv6
	sysctl_values['net.ipv6.conf.all.disable_ipv6'] = 1
	sysctl_values['net.ipv6.conf.default.disable_ipv6'] = 1
end

template '/etc/sysctl.conf' do
	source 'etc/sysctl.conf.erb'
	owner 'root'
	group 'root'
	mode 0644
	variables({
		:sysctl_values => sysctl_values
	})
end

sysctl_values.each do |k, v|
	execute "sysctl #{k}" do
		command "sysctl -w #{k}=#{v}"
		not_if "[[ $(sysctl -n #{k}) == \"#{v}\" ]]"
		notifies :run, 'execute[sysctl route flush]', :delayed
	end
end

execute 'sysctl route flush' do
	command 'sysctl -w net.ipv4.route.flush=1'
	action :nothing
end
