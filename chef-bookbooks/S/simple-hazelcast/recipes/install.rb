# frozen_string_literal: true
hazelcast_jar = ::File.join(node['hazelcast']['home'], ::File.basename(node['hazelcast']['download_url']))
node.default['hazelcast']['class_path']['hazelcast-jar'] = hazelcast_jar

directory node['hazelcast']['home'] do
  owner node['hazelcast']['user']
  group node['hazelcast']['group']

  recursive true
end

remote_file 'hazelcast-jar' do
  path hazelcast_jar
  source node['hazelcast']['download_url']

  owner node['hazelcast']['user']
  group node['hazelcast']['group']
  checksum node['hazelcast']['checksum']
end
