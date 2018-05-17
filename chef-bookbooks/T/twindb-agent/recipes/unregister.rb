#
# Cookbook Name:: twindb-agent
# Recipe:: unregister
#

# Here we unregister the MySQL instance with twindb-agent
bash "twindb_unregister" do
    user "root"
    code <<-EOH
        /usr/bin/twindb-agent --unregister --delete-backups
    EOH
    not_if "/usr/bin/twindb-agent --is-registered | grep NO"
end
