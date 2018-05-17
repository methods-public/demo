#
# Cookbook Name:: twindb-agent
# Recipe:: backup
#

# Here we backup the MySQL instance once with twindb
# This is normally going to be used for testing purposes
bash "twindb_backup" do
    user "root"
    code <<-EOH
        /usr/bin/twindb-agent --backup
    EOH
end
