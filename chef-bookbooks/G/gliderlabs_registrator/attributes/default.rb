#
# Cookbook Name:: gliderlabs_registrator
# Attributes:: default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#

# Install options
default['gliderlabs_registrator']['install_method'] = 'source_docker'
default['gliderlabs_registrator']['registrator_repo'] = 'gliderlabs/registrator'
default['gliderlabs_registrator']['registrator_tag'] = 'latest'
default['gliderlabs_registrator']['golang_docker_repo'] = 'golang'
default['gliderlabs_registrator']['golang_docker_tag'] = 'latest'
default['gliderlabs_registrator']['bin_path'] = '/usr/local/bin'
default['gliderlabs_registrator']['src_command'] = 'go get -v github.com/gliderlabs/registrator'
default['gliderlabs_registrator']['conf_dir'] = '/etc/registrator'

# Run options
default['gliderlabs_registrator']['docker_sock'] = 'unix:///var/run/docker.sock'
default['gliderlabs_registrator']['registrator_bin'] = 'registrator'
default['gliderlabs_registrator']['start_registrator_bin'] = 'start_registrator.sh'
default['gliderlabs_registrator']['run_opts']['backend'] = 'consul://127.0.0.1:8500'
default['gliderlabs_registrator']['run_opts']['cleanup'] = true
default['gliderlabs_registrator']['run_opts']['deregister'] = 'always'
default['gliderlabs_registrator']['run_opts']['internal'] = false
default['gliderlabs_registrator']['run_opts']['ip'] = nil
default['gliderlabs_registrator']['run_opts']['resync'] = nil
default['gliderlabs_registrator']['run_opts']['retry-attempts'] = nil
default['gliderlabs_registrator']['run_opts']['retry-interval'] = 2000
default['gliderlabs_registrator']['run_opts']['tags'] = nil
default['gliderlabs_registrator']['run_opts']['ttl'] = nil
default['gliderlabs_registrator']['run_opts']['ttl-refresh'] = nil
default['gliderlabs_registrator']['run_opts']['run_user'] = 'root'

# Docker-specific options
default['gliderlabs_registrator']['docker_bind'] = '/var/run/docker.sock:/tmp/docker.sock'
