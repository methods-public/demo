#
# Cookbook:: aerospike
# Recipe:: conf
#
template 'aerospike-conf' do
  path     '/etc/aerospike/aerospike.conf'
  source   'aerospike.conf.erb'
  variables(conf: node['aerospike']['conf'])
end
