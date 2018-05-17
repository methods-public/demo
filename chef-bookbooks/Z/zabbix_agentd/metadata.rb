name 'zabbix_agentd'
maintainer 'cduong13'
maintainer_email 'chris.duong83@gmail.com'
license 'mit'
description 'Installs/Configures zabbix_agentd'
long_description 'Installs/Configures zabbix_agentd'
version '0.1.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
issues_url 'https://github.com/chrisduong/chef-zabbix_agentd/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
source_url 'https://github.com/chrisduong/chef-zabbix_agentd' if respond_to?(:source_url)

%w(redhat centos).each do |el|
  supports el, '>= 6.0'
end
