# frozen_string_literal: true
include_recipe 'runit'

runit_service 'hazelcast' do
  default_logger true
  options(
    'user' => node['hazelcast']['user'],
    'home' => node['hazelcast']['home'],
    'java_home' => node['hazelcast']['java_home'],
    'java_opts' => node['hazelcast']['java_opts'],
    'java_class_path' => node['hazelcast']['class_path']
  )
  subscribes :restart, 'remote_file[hazelcast-jar]'

  action [:enable, :start]
end
