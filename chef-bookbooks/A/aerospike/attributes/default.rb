#
# Package selection helpers
#

# artifact name per platform
artifact_name = value_for_platform_family(
  rhel:    'el' + node['platform_version'].split('.').first,
  default: node['platform'] + node['platform_version'].split('.').first
)
# checksum per artifact name
server_pkg_checksum = {
  el6:      '9841458ee000d70e7fb7d0b046c4f957f2aa1899058bcf4e8f0bb135855b0c41',
  el7:      'a66d9ee8cd8e11d20079a34a85e4255d2925b0f733815625cc2e61f9da3d94ed',
  debian7:  'a7189f7d802b5d805d5d6e432b58de86c4db97bde482be255e58e61ef688362c',
  debian8:  'f0d0cf17d397c395efe07e78bc040789f2cc68b8654a6834744b9dae3ee622ca',
  ubuntu12: 'de85946b1a98143a6c696f8c0b962be284658b7c107c77261c236b750d3b806e',
  ubuntu14: 'af6470fd9d5933c5641c2fec5eb8372aa5e49360c5ae7d00d51c4b4c0a02302b',
  ubuntu16: 'ec278ffe0f83e20230c66edc89c0ee00945eb039bca51530ec5644fa239b94fe'
}

#
# Package
#
default['aerospike']['server']['version'] = '3.14.1.4'
default['aerospike']['server']['edition'] = 'community'

default['aerospike']['server']['pkg']['dir'] = '/var/cache/aerospike/server/'
default['aerospike']['server']['pkg']['url'] = 'https://www.aerospike.com/download/server/' +
                                               node['aerospike']['server']['version']       +
                                               '/artifact/' + artifact_name
default['aerospike']['server']['pkg']['checksum'] = server_pkg_checksum[artifact_name.to_sym]

#
# Configuration
#
default['aerospike']['conf']['logging']['console']['context']   = 'any info'
default['aerospike']['conf']['network']['service']['address']   = 'any'
default['aerospike']['conf']['network']['service']['port']      = 3000
default['aerospike']['conf']['network']['heartbeat']['mode']    = 'mesh'
default['aerospike']['conf']['network']['heartbeat']['address'] = node['ipaddress']
default['aerospike']['conf']['network']['heartbeat']['port']    = 3002
default['aerospike']['conf']['network']['fabric']['port']       = 3001
default['aerospike']['conf']['network']['info']['port']         = 3003
