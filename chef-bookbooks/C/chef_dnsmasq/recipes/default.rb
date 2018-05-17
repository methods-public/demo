Array(node['dnsmasq']['packages']).each do |pkg|
  package pkg
end

service node['dnsmasq']['service'] do
  action [:enable, :start]
end

node['dnsmasq'].each do |k, _v|
  case k
  when 'conf', 'packages', 'service', 'user', 'group'
    next
  else
    template '/etc/default/dnsmasq' do
      source 'dnsmasq.conf.erb'
      owner 'root'
      group 'root'
      mode 0644
      variables({ :enabled => node['dnsmasq']['enabled'], :config_dir => node['dnsmasq']['config_dir'], :ignore_resolvconf => node['dnsmasq']['ignore_resolvconf'] })
      notifies :reload, 'service[dnsmasq]', :delayed
    end
    break
  end
end

unless node['dnsmasq']['conf_dir'].nil?
  directory node['dnsmasq']['conf_dir'] do
    owner node['dnsmasq']['user']
    group node['dnsmasq']['group']
    mode 0755
    recursive true
    action :create
  end

  node['dnsmasq']['conf'].each do |k, v|
    next if v.nil?
    fname = ''
    case k
    when 'global'
      fname = node['dnsmasq']['conf_file']
    when 'dns', 'dhcp', 'tftp'
      fname = ::File.join(node['dnsmasq']['conf']['conf_dir'], "#{k}.conf")
    else
      next
    end
    value = Mash.new
    value = v
    template k do
      path fname
      source "#{k}.conf.erb"
      owner node['dnsmasq']['user']
      group node['dnsmasq']['group']
      mode 00644
      variables({
                  :vars => value
                })
      notifies :reload, 'service[dnsmasq]', :delayed
    end
  end
end

if !node['dnsmasq']['conf']['tftp'].nil? && !node['dnsmasq']['conf']['tftp']['tftp-root'].nil?
  directory node['dnsmasq']['conf']['tftp']['tftp-root'] do
    owner node['dnsmasq']['user']
    group node['dnsmasq']['group']
    mode 0755
    recursive true
    action :create
  end
end

unless node['dnsmasq']['conf']['dhcp'].nil?
  unless node['dnsmasq']['conf']['dhcp']['dhcp-hostsfile'].nil?
    if node['dnsmasq']['conf']['dhcp']['dhcp-hostsfile'][-1, 1] == '/'
      directory node['dnsmasq']['conf']['dhcp']['dhcp-hostsfile'] do
        owner node['dnsmasq']['user']
        group node['dnsmasq']['group']
        mode 0755
        recursive true
        action :create
      end
    else
      file node['dnsmasq']['conf']['dhcp']['dhcp-hostsfile'] do
        owner node['dnsmasq']['user']
        group node['dnsmasq']['group']
        mode 0644
        action :create
      end
    end
  end
  
  unless node['dnsmasq']['conf']['dhcp']['dhcp-optsfile'].nil?
    if node['dnsmasq']['conf']['dhcp']['dhcp-optsfile'][-1, 1] == '/'
      directory node['dnsmasq']['conf']['dhcp']['dhcp-optsfile'] do
        owner node['dnsmasq']['user']
        group node['dnsmasq']['group']
        mode 0755
        recursive true
      action :create
      end
    else
      file node['dnsmasq']['conf']['dhcp']['dhcp-optsfile'] do
      owner node['dnsmasq']['user']
        group node['dnsmasq']['group']
        mode 0644
        action :create
      end
    end
  end
end
