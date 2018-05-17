#
# Cookbook Name:: vulcand
# Resource:: vulcand_docker
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#
actions :start, :stop, :restart
default_action :start

# Docker-specific options
attribute :vulcand_docker_repo, String, default: node['vulcand']['vulcand_docker_repo']
attribute :vulcand_docker_tag, [String, nil], default: node['vulcand']['vulcand_docker_tag']
attribute :container_name, String, default: node['vulcand']['container_name']
attribute :container_port, [String, Array], default: node['vulcand']['container_port']
attribute :network_mode, String, default: node['vulcand']['network_mode']
attribute :vulcand_docker_bin, String, default: node['vulcand']['vulcand_docker_bin']
# Install options
attribute :bin_path, String, default: node['vulcand']['bin_path']
attribute :conf_dir, String, default: node['vulcand']['conf_dir']
# General options
attribute :apiInterface, kind_of: String, default: node['vulcand']['run_opts']['apiInterface']
attribute :apiPort, kind_of: Integer, default: node['vulcand']['run_opts']['apiPort']
attribute :certPath, kind_of: String, default: node['vulcand']['run_opts']['certPath']
attribute :default_listener, kind_of: [TrueClass, FalseClass], default: node['vulcand']['run_opts']['default_listener']
attribute :endpointDialTimeout, kind_of: String, default: node['vulcand']['run_opts']['endpointDialTimeout']
attribute :endpointReadTimeout, kind_of: String, default: node['vulcand']['run_opts']['endpointReadTimeout']
attribute :etcd, kind_of: String, default: node['vulcand']['run_opts']['etcd']
attribute :etcdCaFile, kind_of: String, default: node['vulcand']['run_opts']['etcdCaFile']
attribute :etcdCertFile, kind_of: String, default: node['vulcand']['run_opts']['etcdCertFile']
attribute :etcdConsistency, kind_of: String, default: node['vulcand']['run_opts']['etcdConsistency']
attribute :etcdKey, kind_of: String, default: node['vulcand']['run_opts']['etcdKey']
attribute :etcdKeyFile, kind_of: String, default: node['vulcand']['run_opts']['etcdKeyFile']
attribute :etcdSyncIntervalSeconds, kind_of: Integer, default: node['vulcand']['run_opts']['etcdSyncIntervalSeconds']
attribute :interface, kind_of: String, default: node['vulcand']['run_opts']['interface']
attribute :log, kind_of: String, default: node['vulcand']['run_opts']['log']
attribute :logSeverity, kind_of: String, default: node['vulcand']['run_opts']['logSeverity']
attribute :pidPath, kind_of: String, default: node['vulcand']['run_opts']['pidPath']
attribute :port, kind_of: Integer, default: node['vulcand']['run_opts']['port']
attribute :readTimeout, kind_of: String, default: node['vulcand']['run_opts']['readTimeout']
attribute :sealKey, kind_of: String, default: node['vulcand']['run_opts']['sealKey']
attribute :serverMaxHeaderBytes, kind_of: Integer, default: node['vulcand']['run_opts']['serverMaxHeaderBytes']
attribute :serverReadTimeout, kind_of: String, default: node['vulcand']['run_opts']['serverReadTimeout']
attribute :serverWriteTimeout, kind_of: String, default: node['vulcand']['run_opts']['serverWriteTimeout']
attribute :statsdAddr, kind_of: String, default: node['vulcand']['run_opts']['statsdAddr']
attribute :statsdPrefix, kind_of: String, default: node['vulcand']['run_opts']['statsdPrefix']
