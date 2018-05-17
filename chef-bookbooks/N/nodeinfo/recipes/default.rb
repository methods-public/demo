require 'json'
ohai_plugin 'nodeinfo'
return if node['nodeinfo'].nil?
directory '/etc/nodeinfo'

file '/etc/nodeinfo/info.json' do
  content lazy { node['nodeinfo'].to_json }
  mode '444'
end
