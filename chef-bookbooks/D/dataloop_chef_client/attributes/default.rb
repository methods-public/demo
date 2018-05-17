default['dataloop-chef-client']['chef-conf-dir'] = '/etc/chef'
default['dataloop-chef-client']['client-rb'] = 'client.rb'
default['dataloop-chef-client']['client-key'] = 'client.pem'
default['dataloop-chef-client']['ssl-verify-mode'] = ''
default['dataloop-chef-client']['warning'] = 3_600
default['dataloop-chef-client']['critical'] = 86_400
default['dataloop-chef-client']['output-dir'] = '/var/opt'
default['dataloop-chef-client']['output-name'] = 'dataloop_chef_client.out'
default['dataloop-chef-client']['output-path'] = format(
  '%s/%s',
  node['dataloop-chef-client']['output-dir'],
  node['dataloop-chef-client']['output-name']
)
default['dataloop-chef-client']['plugin-path'] =
  '/opt/dataloop/plugins/dataloop_chef_client.sh'
default['dataloop-chef-client']['script-path'] =
  '/usr/local/bin/dataloop_chef_client.rb'
default['dataloop-chef-client']['user'] = 'root'
default['dataloop-chef-client']['minutes'] = '*/10'
default['dataloop-chef-client']['client-rb-path'] = format(
  '%s/%s',
  node['dataloop-chef-client']['chef-conf-dir'],
  node['dataloop-chef-client']['client-rb']
)
default['dataloop-chef-client']['client-key-path'] = format(
  '%s/%s',
  node['dataloop-chef-client']['chef-conf-dir'],
  node['dataloop-chef-client']['client-key']
)
