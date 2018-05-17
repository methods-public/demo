# 8.1 Set Warning Banner for Standard Login Services
# 8.2 Remove OS Information from Login Warning Banners
['issue', 'issue.net', 'motd'].each do |f|
	file "/etc/#{f}" do
		content node['cis_centos6']['banners']['content']
		owner 'root'
		group 'root'
		mode 0644
	end
end
