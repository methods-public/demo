#
# Cookbook:: chef-collectd
# Recipe:: config
#

[node['collectd']['dir'], "#{node['collectd']['dir']}/collectd.conf.d"].each do |dir|
  directory dir do
    mode '0755'
  end
end

file 'collectd.conf' do
  mode    '0644'
  path    "#{node['collectd']['dir']}/collectd.conf"
  content node['collectd']['conf'].keys
                                  .map { |k| "Include \"#{node['collectd']['dir']}/collectd.conf.d/#{k}.conf\"\n" }
                                  .join
end

node['collectd']['conf'].each do |file, conf|
  template "collectd_#{file}" do
    mode     '0644'
    source   'conf.erb'
    path     "#{node['collectd']['dir']}/collectd.conf.d/#{file}.conf"
    variables(conf: conf)
  end
end
