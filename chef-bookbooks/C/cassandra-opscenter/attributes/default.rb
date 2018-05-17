###
# External variables

# The default is too small for a typical ec2 hostname - this needs to be set above 64
override[:nginx][:server_names_hash_bucket_size] = 512 

###
# Cassandra variables

# Multi region switch variable: in this cookbook the agent config is different depending on this variable.
# We use the variable from the cassandra-priam cookbook, which this cookbook was written alongside.
default[:cassandra][:priam_multiregion_enable] = nil

###
# Opscenter variables

# We will create this user on the leader-elected server.
default[:cassandra][:opscenter][:user] = "opscenter"
default[:cassandra][:opscenter][:group] = "opscenter"


# A top level directory attribute is provided should you wish to install elsewhere.
default[:cassandra][:opscenter][:parentdir] = "/opt"
default[:cassandra][:opscenter][:home] = "#{node[:cassandra][:opscenter][:parentdir]}/opscenter"

# What version to install, where to get it and a checksum to guarantee it is valid.
default[:cassandra][:opscenter][:version] = "4.1.2"
default[:cassandra][:opscenter][:src_url] = "http://downloads.datastax.com/community/opscenter-#{node['cassandra']['opscenter']['version']}.tar.gz"
default[:cassandra][:opscenter][:checksum] = "1d61404bc7855d7002fea15fcfa7fcc8500e27ba450c4b9eee7db74cb0613967"

# We create fill in this attribute dynamically mid-chef-run on the host that installs the server and generates the package.
default[:cassandra][:opscenter][:agent][:checksum] = nil

# For agent distribution and proxying/redirect to the opscenter interface on the default http port
default[:cassandra][:opscenter][:server_port] = "8888"

# By default it seems SSL doesn't work on version 4.x, but if 3.x is used it works fine.
# This attribute can be used to force SSL agent communications. YMMV. default off.
default[:cassandra][:opscenter][:use_ssl] = "0"


