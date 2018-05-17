#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: docker
#

include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Build a data structure with configuration.
# @example
#   node.override['oneapm-ci-agent']['docker']['instances'] = [
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

oneapm_ci_agent_monitor 'docker' do
  init_config node['oneapm-ci-agent']['docker']['init_config']
  instances node['oneapm-ci-agent']['docker']['instances']
end
