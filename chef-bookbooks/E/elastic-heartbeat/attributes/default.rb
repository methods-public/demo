default['heartbeat']['version'] = '6.2.3'
default['heartbeat']['release'] = '1'
default['heartbeat']['disable_service'] = false
default['heartbeat']['setup_repo'] = true

default['heartbeat']['ignore_version'] = false
default['heartbeat']['notify_restart'] = true

default['heartbeat']['service']['init_style'] = 'init' # or runit
default['heartbeat']['service']['retries'] = 0
default['heartbeat']['service']['retry_delay'] = 2

default['heartbeat']['conf_dir'] = '/etc/heartbeat'
default['heartbeat']['conf_file'] = ::File.join(node['heartbeat']['conf_dir'], 'heartbeat.yml')
default['heartbeat']['monitors_dir'] = ::File.join(node['heartbeat']['conf_dir'], 'conf.d')
