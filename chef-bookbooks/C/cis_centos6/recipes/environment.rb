# 7.1.1 Set Password Expiration Days
# 7.1.2 Set Password Change Minimum Number of Days
# 7.1.3 Set Password Expiring Warning Days
template '/etc/login.defs' do
	source 'etc/login.defs.erb'
	mode '0644'
	owner 'root'
	group 'root'
	variables({
		:pass_max_days => node['cis_centos6']['environment']['login']['pass_max_days'],
		:pass_min_days => node['cis_centos6']['environment']['login']['pass_min_days'],
		:pass_warn_age => node['cis_centos6']['environment']['login']['pass_warn_age']
	})
end

# 7.2 Disable System Accounts
script 'disable system accounts' do
	interpreter 'bash'
	code <<-EOH
		for user in `awk -F: '($3 < 500) {print $1 }' /etc/passwd`; do
			if [ $user != "root" ]
			then
				/usr/sbin/usermod -L $user
				if [ $user != "sync" ] && [ $user != "shutdown" ] && [ $user != "halt" ]#{node['cis_centos6']['environment']['system_accounts_requiring_shell'].map { |acc| ' && [ $user != "' + acc + '" ]' }.join}
				then
					/usr/sbin/usermod -s /sbin/nologin $user
				fi
			fi
		done
		EOH
	only_if "[[ $(egrep -v \"^\\+\" /etc/passwd | awk -F: '($1!=\"root\" && $1!=\"sync\" && $1!=\"shutdown\" && $1!=\"halt\"#{node['cis_centos6']['environment']['system_accounts_requiring_shell'].map { |acc| ' && $1!= "' + acc + '"' }.join} && $3<500 && $7!=\"/sbin/nologin\") {print}') ]]"
end

# 7.3 Set Default Group for root Account
user 'root' do
	gid 0
end

# 7.4 Set Default umask for Users
template '/etc/profile' do
	source 'etc/profile.erb'
	mode '0644'
	owner 'root'
	group 'root'
end

template '/etc/bashrc' do
	source 'etc/bashrc.erb'
	mode '0644'
	owner 'root'
	group 'root'
end

# 7.5 Lock Inactive User Accounts
execute 'Lock Inactive User Accounts' do
	command 'useradd -D -f 35'
	only_if { node['cis_centos6']['environment']['lock_inactive_user_accounts'] }
	not_if 'useradd -D | grep INACTIVE=35'
end
