#
# Cookbook Name:: twindb-repo
# Attributes:: default
#

# Package cloud
default["twindb_agent"]["package_cloud"]["username"] = "twindb"

case node["platform"]
when "amazon"
  default["twindb_agent"]["package_cloud"]["repo_name"]["prod"] = "amzn_main"
  default["twindb_agent"]["package_cloud"]["repo_name"]["develop"] = "amzn_develop"
else
  default["twindb_agent"]["package_cloud"]["repo_name"]["prod"] = "main"
  default["twindb_agent"]["package_cloud"]["repo_name"]["develop"] = "develop"
end
