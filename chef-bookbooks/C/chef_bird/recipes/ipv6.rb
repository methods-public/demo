service node['bird']['service_ipv6'] do
  action [:enable]
  supports status: true, restart: true, reload: true
end

directory ::File.dirname(node['bird']['include_path6']) do
  owner 'root'
  group 'root'
  mode 0o755
  recursive true
  action :create
end

unless node['bird']['ipv6']['includes'].nil?
  node['bird']['ipv6']['includes'].each do |name, values|
    dpath = ::File.dirname(node['bird']['include_path6'])
    dpath = ::File.dirname(values['path']) unless values['path'].nil?
    directory dpath do
      owner 'root'
      group 'root'
      mode 0o755
      recursive true
      action :create
      not_if { dpath.empty? }
    end

    file name do
      path ::File.join(dpath, name)
      owner 'root'
      group 'root'
      mode 0o644
      content values['source'].join("\n")
      action :create
      not_if { values['source'].nil? }
    end
  end
end

unless node['bird']['config']['ipv4']['router id'].nil?
  if node['bird']['config']['ipv4']['router id'] == 'generate'
    require 'digest/sha1'
    node.default['bird']['config']['ipv4']['router id'] = Digest::SHA1.hexdigest(node['fqdn'])[0..7].to_i(16)
  elsif node['bird']['config']['ipv4']['router id'].count('.') != 3
    from = node['bird']['config']['ipv4']['router id']
    addr = node['network']['interfaces'][from]['addresses'].find { |_ip, attrs| attrs['family'] == 'inet' }
    node.default['bird']['config']['ipv4']['router id'] = addr[0]
  end
end

template node['bird']['config_ipv6'] do
  source 'bird6.conf.erb'
  mode 0o644
  owner 'root'
  group 'root'
  notifies :start, "service[#{node['bird']['service_ipv6']}]", :immediately
  notifies :reload, "service[#{node['bird']['service_ipv6']}]", :immediately
end
