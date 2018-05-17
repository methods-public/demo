#
# Cookbook Name:: docker-etcd-registrator
# Resource:: docker-etcd-registrator_default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#

default['docker-etcd-registrator']['conf_dir'] = '/etc/docker-etcd-registrator'
default['docker-etcd-registrator']['binary'] = 'docker-etcd-registrator'
default['docker-etcd-registrator']['run_user'] = 'root'

default['docker-etcd-registrator']['hostname'] = nil
default['docker-etcd-registrator']['register'] = nil
default['docker-etcd-registrator']['register_public_ip'] = nil
default['docker-etcd-registrator']['force_public_ip'] = nil
default['docker-etcd-registrator']['skydns_prefix'] = nil
default['docker-etcd-registrator']['vulcand_prefix'] = nil
default['docker-etcd-registrator']['docker_host'] = nil
default['docker-etcd-registrator']['docker_tls_verify'] = nil
default['docker-etcd-registrator']['docker_cert_path'] = nil
default['docker-etcd-registrator']['etcd_endpoints'] = nil
default['docker-etcd-registrator']['etcd_cafile'] = nil
default['docker-etcd-registrator']['etcd_certfile'] = nil
default['docker-etcd-registrator']['etcd_keyfile'] = nil
