default['yum']['powerdns-auth']['description'] = 'PowerDNS Authoritative Server Repository'
default['yum']['powerdns-auth']['baseurl'] = 'http://repo.powerdns.com/centos/$basearch/$releasever/auth-40'
default['yum']['powerdns-auth']['gpgkey'] = 'https://repo.powerdns.com/FD380FBB-pub.asc'
default['yum']['powerdns-auth']['gpgcheck'] = true
default['yum']['powerdns-auth']['enabled'] = true
default['yum']['powerdns-auth']['priority'] = '90'
default['yum']['powerdns-auth']['managed'] = true

default['yum']['powerdns-auth-debug']['description'] = 'PowerDNS Authoritative Server Debuginfo Repository'
default['yum']['powerdns-auth-debug']['baseurl'] = 'http://repo.powerdns.com/centos/$basearch/$releasever/auth-40/debug'
default['yum']['powerdns-auth-debug']['gpgkey'] = 'https://repo.powerdns.com/FD380FBB-pub.asc'
default['yum']['powerdns-auth-debug']['gpgcheck'] = true
default['yum']['powerdns-auth-debug']['enabled'] = false
default['yum']['powerdns-auth-debug']['priority'] = '90'
default['yum']['powerdns-auth-debug']['managed'] = true

default['yum']['powerdns-rec']['description'] = 'PowerDNS Recursor Repository'
default['yum']['powerdns-rec']['baseurl'] = 'http://repo.powerdns.com/centos/$basearch/$releasever/rec-40'
default['yum']['powerdns-rec']['gpgkey'] = 'https://repo.powerdns.com/FD380FBB-pub.asc'
default['yum']['powerdns-rec']['gpgcheck'] = true
default['yum']['powerdns-rec']['enabled'] = true
default['yum']['powerdns-rec']['priority'] = '90'
default['yum']['powerdns-rec']['managed'] = true

default['yum']['powerdns-rec-debug']['description'] = 'PowerDNS Recursor Debuginfo Repository'
default['yum']['powerdns-rec-debug']['baseurl'] = 'http://repo.powerdns.com/centos/$basearch/$releasever/rec-40/debug'
default['yum']['powerdns-rec-debug']['gpgkey'] = 'https://repo.powerdns.com/FD380FBB-pub.asc'
default['yum']['powerdns-rec-debug']['gpgcheck'] = true
default['yum']['powerdns-rec-debug']['enabled'] = false
default['yum']['powerdns-rec-debug']['priority'] = '90'
default['yum']['powerdns-rec-debug']['managed'] = true
