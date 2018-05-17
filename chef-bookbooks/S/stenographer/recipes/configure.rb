
template '/etc/stenographer/config' do
  source 'stenographer.config.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  variables ({ :threads => node['stenographer']['threads'] })
end

node['stenographer']['threads'].each do |thread|
  directory thread['packets_dir'] do
    action :create
    recursive true
    owner node['stenographer']['user']
    group node['stenographer']['group']
  end

  directory thread['index_dir'] do
    action :create
    recursive true
    owner node['stenographer']['user']
    group node['stenographer']['group']
  end
end
