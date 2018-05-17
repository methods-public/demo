# Required for integration test via test-kitchen
#
# http://kitchen.ci/ for more information

attrs = node['dataloop-chef-client']

template attrs['script-path'] do
  source 'dataloop_chef_client.rb.erb'
  mode 0755
  variables(
    chef_server_url: attrs['chef-server-url'],
    client_rb: attrs['client-rb-path'],
    client_key: attrs['client-key-path'],
    ssl_verify_mode: attrs['ssl-verify-mode'],
    output_path: attrs['output-path'],
    warning: attrs['warning'],
    critical: attrs['critical']
  )
end

template attrs['plugin-path'] do
  source 'dataloop_chef_client.sh.erb'
  mode 0755
  owner 'dataloop'
  group 'dataloop'
  variables output_path: attrs['output-path']
end

cron 'dataloop_chef_client' do
  minute attrs['minutes']
  hour '*'
  weekday '*'
  user attrs['user']
  command attrs['script-path']
end
