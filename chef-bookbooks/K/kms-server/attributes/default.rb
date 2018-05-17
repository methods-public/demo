# The Key used to enable KMS Host service
default['kms_server']['host_key'] = nil

# Disable DNS publishing
default['kms_server']['disable_dns_publishing'] = false
# Domain list used for DNS publishing of the KMS Host entry
default['kms_server']['dns_publishing_domains'] = []
# Reduces process priority assigned to KMS service
default['kms_server']['reduce_kms_priority'] = false
# KMS TCP listening port
default['kms_server']['listening_port'] = '1688'
# Activation interval in minutes
default['kms_server']['activation_interval'] = 120
# Renewal interval in minutes
default['kms_server']['renewal_interval'] = 10_080
