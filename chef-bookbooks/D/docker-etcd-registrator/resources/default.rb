#
# Cookbook Name:: docker-etcd-registrator
# Resource:: docker-etcd-registrator_default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#

default_action :create

attribute :conf_dir, kind_of: String, default: node['docker-etcd-registrator']['conf_dir']
attribute :docker_etcd_registrator_bin, kind_of: String, default: node['docker-etcd-registrator']['binary']
attribute :run_user, kind_of: String, default: node['docker-etcd-registrator']['run_user']

attribute :hostname, kind_of: [String, nil], default: node['docker-etcd-registrator']['hostname']
attribute :register, kind_of: [String, nil], default: node['docker-etcd-registrator']['register']
attribute :register_public_ip, kind_of: [String, nil], default: node['docker-etcd-registrator']['register_public_ip']
attribute :force_public_ip, kind_of: [String, nil], default: node['docker-etcd-registrator']['force_public_ip']
attribute :skydns_prefix, kind_of: [String, nil], default: node['docker-etcd-registrator']['skydns_prefix']
attribute :vulcand_prefix, kind_of: [String, nil], default: node['docker-etcd-registrator']['vulcand_prefix']
attribute :docker_host, kind_of: [String, nil], default: node['docker-etcd-registrator']['docker_host']
attribute :docker_tls_verify, kind_of: [String, nil], default: node['docker-etcd-registrator']['docker_tls_verify']
attribute :docker_cert_path, kind_of: [String, nil], default: node['docker-etcd-registrator']['docker_cert_path']
attribute :etcd_endpoints, kind_of: [String, nil], default: node['docker-etcd-registrator']['etcd_endpoints']
attribute :etcd_cafile, kind_of: [String, nil], default: node['docker-etcd-registrator']['etcd_cafile']
attribute :etcd_certfile, kind_of: [String, nil], default: node['docker-etcd-registrator']['etcd_certfile']
attribute :etcd_keyfile, kind_of: [String, nil], default: node['docker-etcd-registrator']['etcd_keyfile']
