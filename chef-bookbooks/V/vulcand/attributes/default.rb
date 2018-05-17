#
# Cookbook Name:: vulcand
# Attributes:: default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>

# Install options
default['vulcand']['vulcand_docker_repo'] = 'mailgun/vulcand'
default['vulcand']['vulcand_docker_tag'] = 'v0.8.0-beta.2'
default['vulcand']['golang_docker_repo'] = 'golang'
default['vulcand']['golang_docker_tag'] = 'latest'
default['vulcand']['bin_path'] = '/usr/local/bin'
default['vulcand']['conf_dir'] = '/etc/vulcand'
default['vulcand']['install_method'] = 'source_docker'

# Source compile command
default['vulcand']['src_command'] = 'go get github.com/vulcand/vulcand \
                                            github.com/vulcand/vulcand/vctl \
                                            github.com/vulcand/vulcand/vbundle'

# General run options
default['vulcand']['run_opts']['apiInterface'] = '0.0.0.0'
default['vulcand']['run_opts']['apiPort'] = 8182
default['vulcand']['run_opts']['certPath'] = nil
default['vulcand']['run_opts']['default_listener'] = true
default['vulcand']['run_opts']['endpointDialTimeout'] = '5s'
default['vulcand']['run_opts']['endpointReadTimeout'] = '50s'
default['vulcand']['run_opts']['etcd'] = 'http://localhost:4001'
default['vulcand']['run_opts']['etcdCaFile'] = nil
default['vulcand']['run_opts']['etcdCertFile'] = nil
default['vulcand']['run_opts']['etcdConsistency'] = 'STRONG'
default['vulcand']['run_opts']['etcdKey'] = 'vulcand'
default['vulcand']['run_opts']['etcdKeyFile'] = nil
default['vulcand']['run_opts']['etcdSyncIntervalSeconds'] = 0
default['vulcand']['run_opts']['interface'] = nil
default['vulcand']['run_opts']['log'] = 'console'
default['vulcand']['run_opts']['logSeverity'] = 'warning'
default['vulcand']['run_opts']['pidPath'] = nil
default['vulcand']['run_opts']['port'] = 8181
default['vulcand']['run_opts']['readTimeout'] = '1m0s'
default['vulcand']['run_opts']['sealKey'] = nil
default['vulcand']['run_opts']['serverMaxHeaderBytes'] = 1_048_576
default['vulcand']['run_opts']['serverReadTimeout'] = '1m0s'
default['vulcand']['run_opts']['serverWriteTimeout'] = '1m0s'
default['vulcand']['run_opts']['statsdAddr'] = nil
default['vulcand']['run_opts']['statsdPrefix'] = nil

# Run options for docker
default['vulcand']['container_name'] = 'vulcand'
default['vulcand']['container_port'] = ['8181:8181', '8282:8282']
default['vulcand']['network_mode'] = 'host'
default['vulcand']['vulcand_docker_bin'] = '/go/bin/vulcand'
