default['auditbeat']['yum']['description'] = 'Elastic Beats Repository'
default['auditbeat']['yum']['gpgcheck'] = true
default['auditbeat']['yum']['enabled'] = true
default['auditbeat']['yum']['metadata_expire'] = '3h'
default['auditbeat']['yum']['action'] = :create

default['auditbeat']['apt']['description'] = 'Elastic Beats Repository'
default['auditbeat']['apt']['components'] = %w[stable main]
default['auditbeat']['apt']['distribution'] = node['lsb']['codename'] if node['platform_family'] == 'debian'
default['auditbeat']['apt']['options'] = "-o Dpkg::Options::='--force-confnew' --force-yes"
default['auditbeat']['apt']['action'] = :add
