default[:newrelic_sysmond_policy][:installprereqs] = true
default[:newrelic_sysmond_policy][:path] = '/usr/bin/newrelic-sysmond-policy'

default[:newrelic][:apikey] = nil
default[:newrelic][:server_monitoring][:startup_policy] = 'Default server alert policy'
default[:newrelic][:server_monitoring][:shutdown_policy] = node[:newrelic][:server_monitoring][:startup_policy]
