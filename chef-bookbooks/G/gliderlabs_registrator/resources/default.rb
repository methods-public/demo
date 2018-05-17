#
# Cookbook Name:: gliderlabs_registrator
# Resource:: default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#

actions :create
default_action :create

# Install options
attribute :install_method, kind_of: [String], default: node['gliderlabs_registrator']['install_method']
attribute :registrator_repo, kind_of: [String], default: node['gliderlabs_registrator']['registrator_repo']
attribute :registrator_tag, kind_of: [String], default: node['gliderlabs_registrator']['registrator_tag']
attribute :golang_docker_repo, kind_of: [String], default: node['gliderlabs_registrator']['golang_docker_repo']
attribute :golang_docker_tag, kind_of: [String], default: node['gliderlabs_registrator']['golang_docker_tag']
attribute :bin_path, kind_of: [String], default: node['gliderlabs_registrator']['bin_path']
attribute :src_command, kind_of: [String], default: node['gliderlabs_registrator']['src_command']
attribute :conf_dir, kind_of: [String], default: node['gliderlabs_registrator']['conf_dir']

# Run options
attribute :docker_sock, kind_of: [String], default: node['gliderlabs_registrator']['docker_sock']
attribute :registrator_bin, kind_of: [String], default: node['gliderlabs_registrator']['registrator_bin']
attribute :start_registrator_bin, kind_of: [String], default: node['gliderlabs_registrator']['start_registrator_bin']
attribute :backend, kind_of: [String], default: node['gliderlabs_registrator']['run_opts']['backend']
attribute :cleanup, kind_of: [TrueClass, FalseClass], default: node['gliderlabs_registrator']['run_opts']['cleanup']
attribute :deregister, kind_of: [String, nil], default: node['gliderlabs_registrator']['run_opts']['deregister']
attribute :internal, kind_of: [TrueClass, FalseClass], default: node['gliderlabs_registrator']['run_opts']['internal']
attribute :ip, kind_of: [String, nil], default: node['gliderlabs_registrator']['run_opts']['ip']
attribute :resync, kind_of: [Integer, nil], default: node['gliderlabs_registrator']['run_opts']['resync']
attribute :retry_attempts, kind_of: [Integer, nil], default: node['gliderlabs_registrator']['run_opts']['retry-attempts']
attribute :retry_interval, kind_of: [Integer, nil], default: node['gliderlabs_registrator']['run_opts']['retry-interval']
attribute :tags, kind_of: [String, nil], default: node['gliderlabs_registrator']['run_opts']['tags']
attribute :ttl, kind_of: [Integer, nil], default: node['gliderlabs_registrator']['run_opts']['ttl']
attribute :ttl_refresh, kind_of: [Integer, nil], default: node['gliderlabs_registrator']['run_opts']['ttl-refresh']
attribute :run_user, kind_of: [String], default: node['gliderlabs_registrator']['run_opts']['run_user']

# Docker-specific options
attribute :docker_bind, kind_of: [String], default: node['gliderlabs_registrator']['docker_bind']
