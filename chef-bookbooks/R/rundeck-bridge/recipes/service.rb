#
# Cookbook: rundeck-bridge
# Recipe:   service
#

# Compute final command with every options (even from Wrapper cookbooks)
command = [
  node['rundeck_bridge']['binary'],
  node['rundeck_bridge']['options'].map { |key, value| "--#{key} #{value}" },
].join(' ')


# Overwrite and update the command
# (Workaround for Upstart and logs)
node['rundeck_bridge']['poise_service']['options'].each do |k, v|
  case k
  when 'upstart'
    node.default['rundeck_bridge']['poise_service']['options'][k]['command'] = "#{command} 2>&1 > #{node['rundeck_bridge']['home']}/server.log"
  when 'systemd'
    node.default['rundeck_bridge']['poise_service']['options'][k]['command'] = command
  else
    fail "Unsupported init service #{k}"
  end
end


# Define the chef-rundeck service
#
poise_service 'chef-rundeck' do
  # Common setup for every providers
  user      node['rundeck_bridge']['user']
  directory node['rundeck_bridge']['home']

  # Per init provider options
  node['rundeck_bridge']['poise_service']['options'].each do |k, v|
    options k, v
  end if node['rundeck_bridge']['poise_service']['options']
end
