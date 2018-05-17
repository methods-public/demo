default['bird']['data_bag'] = 'bird'
case node['platform']
when 'debian', 'ubuntu'
  default['bird']['config_ipv4'] = '/etc/bird/bird.conf'
  default['bird']['config_ipv6'] = '/etc/bird/bird6.conf'
  default['bird']['service_ipv4'] = 'bird'
  default['bird']['service_ipv6'] = 'bird6'
  default['bird']['package_ipv4'] = 'bird'
  default['bird']['package_ipv6'] = 'bird6'
  default['bird']['include_path4'] = '/etc/bird/conf.d/*'
  default['bird']['include_path6'] = '/etc/bird/conf.d6/*'
  default['bird']['config']['ipv4'] = nil
  default['bird']['config']['ipv6'] = nil
when 'rhel', 'redhat', 'centos', 'fedora'
  default['bird']['config_ipv4'] = '/etc/bird.conf'
  default['bird']['config_ipv6'] = '/etc/bird6.conf'
  default['bird']['service_ipv4'] = 'bird'
  default['bird']['service_ipv6'] = 'bird6'
  default['bird']['package_ipv4'] = 'bird'
  default['bird']['package_ipv6'] = 'bird6'
  default['bird']['include_path4'] = '/etc/bird.conf.d/*'
  default['bird']['include_path6'] = '/etc/bird6.conf.d/*'
  default['bird']['config']['ipv4'] = nil
  default['bird']['config']['ipv6'] = nil
end
