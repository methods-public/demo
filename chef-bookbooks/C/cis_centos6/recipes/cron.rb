# 6.1.1 Enable anacron Daemon
package 'cronie-anacron'

# 6.2.2 Enable crond Daemon
service 'crond' do
	action [:enable, :start]
end

# 6.1.3 Set User/Group Owner and Permission on /etc/anacrontab
# 6.1.4 Set User/Group Owner and Permission on /etc/crontab
['anacrontab', 'crontab'].each do |tab|
	file "/etc/#{tab}" do
		owner 'root'
		group 'root'
		mode 0600
	end
end

# 6.1.5 Set User/Group Owner and Permission on /etc/cron.hourly
# 6.1.6 Set User/Group Owner and Permission on /etc/cron.daily
# 6.1.7 Set User/Group Owner and Permission on /etc/cron.weekly
# 6.1.8 Set User/Group Owner and Permission on /etc/cron.monthly
# 6.1.9 Set User/Group Owner and Permission on /etc/cron.d
['hourly', 'daily', 'weekly', 'monthly', 'd'].each do |d|
	directory "/etc/cron.#{d}" do
		owner 'root'
		group 'root'
		mode 0700
	end
end

# 6.1.10 Restrict at Daemon
# 6.1.11 Restrict at/cron to Authorised Users
['at', 'cron'].each do |f|
	file "/etc/#{f}.allow" do
		owner 'root'
		group 'root'
		mode 0600
	end
end

['at', 'cron'].each do |f|
	file "/etc/#{f}.deny" do
		action :delete
	end
end
