default['yum']['virtualbox']['description'] = 'VirtualBox'
default['yum']['virtualbox']['baseurl'] = "http://download.virtualbox.org/virtualbox/rpm/el/#{node['platform_version'].to_i}/$basearch"
default['yum']['virtualbox']['gpgkey'] = 'https://www.virtualbox.org/download/oracle_vbox.asc'
default['yum']['virtualbox']['gpgcheck'] = true
default['yum']['virtualbox']['repo_gpgcheck'] = true
default['yum']['virtualbox']['enabled'] = true
default['yum']['virtualbox']['managed'] = true
