packagecloud_repo 'tyk/tyk-pump'

package 'tyk-pump'

template '/opt/tyk-pump/pump.conf' do
  source 'tyk.conf.erb'
  variables(
    config: node['tyk']['pump']['config']
  )
  notifies :restart, 'service[tyk-pump]'
end

service 'tyk-pump' do
  action [:enable, :start]
  supports restart: true, reload: false, status: true
end
