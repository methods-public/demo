#
# Cookbook Name:: twindb-repo
# Recipe:: default
#

# Setup the twindb repository
repository = "#{node["twindb_agent"]["package_cloud"]["username"]}/#{node["twindb_agent"]["package_cloud"]["repo_name"]["prod"]}"
packagecloud_repo repository do
  case node["platform_family"]
  when "debian"
    type "deb"
  when "rhel", "fedora"
    type "rpm"
    priority 9
  end
end
