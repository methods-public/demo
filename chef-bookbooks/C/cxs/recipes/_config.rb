
cxs_config_file = node['cxs']['main_config']
cxs_config = node['cxs']['config']

config_ok = true
missing_list = []
%w(mail options filemax voptions qoptions quarantine ignore xtra).each do |config_param|
  unless cxs_config.has_key?(config_param)
    config_ok = false
    missing_list << config_param
  end
end

if config_ok
  template '/etc/cxs/cxs.defaults' do
    source 'template_equal.erb'
    mode 0600
    variables params: cxs_config
  end
else
  Chef::Log.warn("Cannot create cxs.config because params \"#{missing_list.join(',')}\" are missing")
end 

unless ::File.exist?(node['cxs']['config']['quarantine'])
  execute 'quarantine_create' do
    command '/usr/sbin/cxs --qcreate'
  end
end
