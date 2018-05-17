default['yum']['zabbix']['repositoryid'] = 'zabbix'
default['yum']['zabbix']['enabled'] = true
default['yum']['zabbix']['managed'] = true
default['yum']['zabbix']['gpgkey'] = 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX'
default['yum']['zabbix']['gpgcheck'] = true
default['yum']['zabbix']['release_repo'] = '3.0'

default['yum']['zabbix']['description'] = 'Zabbix Official Repository - $basearch'

default['yum']['zabbix']['baseurl'] = "http://repo.zabbix.com/zabbix/#{node['yum']['zabbix']['release_repo']}/rhel/#{node['platform_version'].to_i}/$basearch/"

