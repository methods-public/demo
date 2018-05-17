# 6.3.1 Upgrade Password Hashing Algorithm to SHA-512
execute 'Upgrade Password Hashing Algorithm to SHA-512' do
	command 'authconfig --passalgo=sha512 --update'
	not_if 'authconfig --test | grep hashing | grep sha512'
end

# 6.3.2 Set Password Creation Requirement Parameters Using pam_cracklib
# 6.3.3 Set Lockout for Failed Password Attempts
# 6.3.4 Limit Password Reuse
['password-auth', 'system-auth'].each do |f|
	template "/etc/pam.d/#{f}" do
		source 'etc/pam.d/system-auth.erb'
		manage_symlink_source true
		owner 'root'
		group 'root'
		mode 0644
	end
end

# 6.5 Restrict Access to the su Command
template '/etc/pam.d/su' do
	source 'etc/pam.d/su.erb'
	owner 'root'
	group 'root'
	mode 0644
	variables({
		:enable_pam_limits => node['cis_centos6']['pam']['enable_pam_limits']
	})
end

group 'wheel' do
	members 'root'
end
