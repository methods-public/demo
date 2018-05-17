# 9.1.2 Verify Permissions on /etc/passwd
# 9.1.5 Verify Permissions on /etc/group
# 9.1.6 Verify User/Group Ownership on /etc/passwd
# 9.1.9 Verify User/Group Ownership on /etc/group
['passwd', 'group'].each do |f|
	file "/etc/#{f}" do
		owner 'root'
		group 'root'
		mode 0644
	end
end

# 9.1.3 Verify Permissions on /etc/shadow
# 9.1.4 Verify Permissions on /etc/gshadow
# 9.1.7 Verify User/Group Ownership on /etc/shadow
# 9.1.8 Verify User/Group Ownership on /etc/gshadow
['shadow', 'gshadow'].each do |f|
	file "/etc/#{f}" do
		owner 'root'
		group 'root'
		mode 0000
	end
end
