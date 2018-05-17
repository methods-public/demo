#
# Cookbook Name:: twindb-agent
# Recipe:: register
#

# Here we register the MySQL instance with twindb
bash "twindb_register" do
    user "root"
    code <<-EOH
        /usr/bin/twindb-agent --register #{node["twindb_agent"]["registration_code"]}
    EOH
    not_if "/usr/bin/twindb-agent --is-registered | grep YES"
end
