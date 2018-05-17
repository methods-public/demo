packagecloud_repo 'tyk/tyk-gateway'

package 'tyk-gateway'

template '/opt/tyk-gateway/tyk.conf' do
  source 'tyk.conf.erb'
  variables(
    config: node['tyk']['gateway']['config']
  )
  notifies :restart, 'service[tyk-gateway]'
end

service 'tyk-gateway' do
  action [:enable, :start]
  supports restart: true, reload: false, status: true
end
