default['syncGateway']['edition'] = "community"
default['syncGateway']['version'] = "1.1.0"
default['syncGateway']['build'] = "28"

case node['platform']
when "windows"
    default['syncGateway']['package_file'] = "couchbase-sync-gateway-#{node['syncGateway']['edition']}_#{node['syncGateway']['version']}-#{node['syncGateway']['build']}_x86_64.exe"
else
    Chef::Log.error("Couchbase Sync Gateway is not supported on #{node['platform_family']}")
end

default['syncGateway']['package_base_url'] = "http://packages.couchbase.com/releases/couchbase-sync-gateway/#{node['syncGateway']['version']}"
default['syncGateway']['package_full_url'] = "#{node['syncGateway']['package_base_url']}/#{node['syncGateway']['package_file']}"

case node['platform_family']
when "windows"
  default['syncGateway']['install_dir'] = File.join("C:","Program Files (x86)","CouchbaseSyncGateway")
else
  default['syncGateway']['install_dir'] = "/opt/couchbase-sync-gateway"
end

default['syncGateway']['service_name'] = 'CouchbaseSyncGateway'

default['syncGateway']['adminInterface'] = '127.0.0.1:4985'
default['syncGateway']['adminUI'] = '127.0.0.1:4985/_admin/'
default['syncGateway']['compressResponses'] = true
default['syncGateway']['interface'] = ':4984'
default['syncGateway']['log'] = ['HTTP']
default['syncGateway']['logFilePath'] = 'stderr'
default['syncGateway']['maxCouchbaseChttponnections'] = 16
default['syncGateway']['maxFileDescriptors'] = 5000
default['syncGateway']['pretty'] = false
default['syncGateway']['slowServerCallWarningThreshold'] = 200

