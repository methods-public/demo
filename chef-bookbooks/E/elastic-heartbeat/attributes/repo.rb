default['heartbeat']['yum']['description'] = 'Elastic Beats Repository'
default['heartbeat']['yum']['gpgcheck'] = true
default['heartbeat']['yum']['enabled'] = true
default['heartbeat']['yum']['metadata_expire'] = '3h'
default['heartbeat']['yum']['action'] = :create

default['heartbeat']['apt']['description'] = 'Elastic Beats Repository'
default['heartbeat']['apt']['components'] = %w[stable main]
default['heartbeat']['apt']['distribution'] = ''
# apt package install options
default['heartbeat']['apt']['options'] = "-o Dpkg::Options::='--force-confnew'"
default['heartbeat']['apt']['action'] = :add
