#
# Cookbook:: aerospike
# Recipe:: service
#
service 'aerospike' do
  subscribes :restart, 'package[aerospike-server]'
  subscribes :restart, 'template[aerospike-conf]'
  action     [:enable, :start]
end
