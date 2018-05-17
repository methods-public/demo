#
# Cookbook Name:: cloudinsight-agent
# Recipe:: docker
#

include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Build a data structure with configuration.
# @example
#   node.override['cloudinsight-agent']['docker']['instances'] = [
#     {
#       url: 'unix://var/run/docker.sock',
#       new_tag_names: 'false',
#       tag_by_command: 'false',
#       tags: ['toto', 'tata'],
#       include: ['docker_image:ubuntu', 'docker_image:debian'],
#       exclude: ['.*'],
#       collect_events: 'true',
#       collect_container_size: 'false',
#       collect_all_metrics: 'false',
#       collect_images_stats: 'false'
#     }
#   ]

cloudinsight_agent_monitor 'docker' do
  init_config node['cloudinsight-agent']['docker']['init_config']
  instances node['cloudinsight-agent']['docker']['instances']
end
