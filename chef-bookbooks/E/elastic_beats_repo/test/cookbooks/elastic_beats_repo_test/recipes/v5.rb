#
# Cookbook:: elastic_beats_repo_test
# Recipe:: v5
#

%w[filebeat packetbeat metricbeat].each do |beat|
  package beat do
    version %w[fedora rhel amazon].include?(node['platform_family']) ? '5.6.9-1' : '5.6.9'
  end
end
