#
# Cookbook:: elastic_beats_repo_test
# Recipe:: v6
#

%w[filebeat packetbeat metricbeat heartbeat-elastic auditbeat].each do |beat|
  package beat do
    version %w[fedora rhel amazon].include?(node['platform_family']) ? '6.2.4-1' : '6.2.4'
  end
end
