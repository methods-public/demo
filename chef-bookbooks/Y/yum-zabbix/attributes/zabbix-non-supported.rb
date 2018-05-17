default['yum']['zabbix-non-supported']['repositoryid'] = 'zabbix-non-supported'
default['yum']['zabbix-non-supported']['enabled'] = false
default['yum']['zabbix-non-supported']['managed'] = false
default['yum']['zabbix-non-supported']['gpgkey'] = 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX'
default['yum']['zabbix-non-supported']['gpgcheck'] = true

default['yum']['zabbix-non-supported']['description'] = 'Zabbix Official Repository - $basearch'
default['yum']['zabbix-non-supported']['baseurl'] = "http://repo.zabbix.com/non-supported/rhel/#{node['platform_version'].to_i}/$basearch/"

