default['yum']['bareos']['description'] = 'BareOS Repository'
default['yum']['bareos']['baseurl'] = 'http://download.bareos.org/bareos/release/latest/CentOS_$releasever'
default['yum']['bareos']['gpgkey'] = 'http://download.bareos.org/bareos/release/latest/CentOS_$releasever/repodata/repomd.xml.key'
default['yum']['bareos']['gpgcheck'] = true
default['yum']['bareos']['enabled'] = true
default['yum']['bareos']['priority'] = '90'
default['yum']['bareos']['managed'] = true
