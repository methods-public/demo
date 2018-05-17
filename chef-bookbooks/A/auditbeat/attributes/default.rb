default['auditbeat']['version'] = '6.0.0-beta1'
default['auditbeat']['release'] = '1'
default['auditbeat']['disable_service'] = false
default['auditbeat']['package_url'] = 'auto'
default['auditbeat']['package_force_overwrite'] = true

default['auditbeat']['ignore_version'] = false
default['auditbeat']['setup_repo'] = true
default['auditbeat']['notify_restart'] = true
default['auditbeat']['windows'] = { 'base_dir' => 'C:/opt/auditbeat' }

default['auditbeat']['service']['name'] = 'auditbeat'
default['auditbeat']['service']['retries'] = 0
default['auditbeat']['service']['retry_delay'] = 2

default['auditbeat']['arch'] = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'x86'
