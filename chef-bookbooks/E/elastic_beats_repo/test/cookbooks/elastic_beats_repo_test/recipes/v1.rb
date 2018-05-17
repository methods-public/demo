#
# Cookbook:: elastic_beats_repo_test
# Recipe:: v1
#

%w[filebeat packetbeat topbeat].each do |beat|
  package beat do
    version %w[fedora rhel amazon].include?(node['platform_family']) ? '1.3.1-1' : '1.3.1'
  end
end
