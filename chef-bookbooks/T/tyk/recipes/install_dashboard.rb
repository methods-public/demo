packagecloud_repo 'tyk/tyk-dashboard'

package 'tyk-dashboard'

template '/opt/tyk-dashboard/tyk_analytics.conf' do
  source 'tyk.conf.erb'
  variables(
    config: node['tyk']['dashboard']['config']
  )
  notifies :restart, 'service[tyk-dashboard]'
end

service 'tyk-dashboard' do
  action [:enable, :start]
  supports restart: true, reload: false, status: true
end
