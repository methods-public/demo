# frozen_string_literal: true
user 'hazelcast user' do
  username node['hazelcast']['user']
  comment 'Hazelcast User'
  home node['hazelcast']['home']
  shell '/bin/bash'
  manage_home false
  action :create
  system true
end

group 'hazelcast group' do
  group_name node['hazelcast']['group']
  action :create
  system true
end
