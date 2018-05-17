#
# Cookbook Name:: mod_pagespeed
# Recipe:: default
#

include_recipe 'apache2::default'

if %w(rhel debian fedora).include?(node['platform_family'])
  case node['platform_family']
  when 'rhel', 'fedora'
    pkg = 'mod-pagespeed.rpm'
  when 'debian'
    pkg = 'mod-pagespeed.deb'
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{pkg}" do
    source node['mod_pagespeed']['package_link']
    mode '0644'
    action :create_if_missing
  end

  package 'mod_pagespeed' do
    source "#{Chef::Config[:file_cache_path]}/#{pkg}"
    action :install
    case node['platform_family']
    when 'rhel', 'fedora'
      provider Chef::Provider::Package::Rpm
    when 'debian'
      provider Chef::Provider::Package::Dpkg
    end
  end

  apache_module 'pagespeed' do
    conf true
    if node['apache']['version'] == '2.2'
      filename 'mod_pagespeed.so'
      #name 'mod_pagespeed'
    elsif node['apache']['version'] == '2.4'
      filename 'mod_pagespeed_ap24.so'
      #name 'mod_pagespeed_ap24'
    end
  end
else
  Chef::Log.warn "apache::mod_pagespeed does not support #{node['platform_family']} yet, and is not being installed"
end
