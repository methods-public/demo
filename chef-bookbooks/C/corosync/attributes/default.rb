#
# Cookbook Name:: corosync
# Attributes:: default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>

default['corosync']['conf_dir'] = '/etc/corosync'
default['corosync']['key_file'] = nil

# Totem attributes
default['corosync']['config']['totem']['version'] = 2
default['corosync']['config']['totem']['crypto_cipher'] = 'aes256'
default['corosync']['config']['totem']['crypto_hash'] = 'sha1'
default['corosync']['config']['totem']['secauth'] = 'on'
default['corosync']['config']['totem']['transport'] = nil
default['corosync']['config']['totem']['rrp_mode'] = nil
default['corosync']['config']['totem']['netmtu'] = nil
default['corosync']['config']['totem']['cluster_name'] = nil
default['corosync']['config']['totem']['config_version'] = nil
default['corosync']['config']['totem']['ip_version'] = nil
default['corosync']['config']['totem']['token'] = nil
default['corosync']['config']['totem']['token_coefficient'] = nil
default['corosync']['config']['totem']['token_retransmit'] = nil
default['corosync']['config']['totem']['hold'] = nil
default['corosync']['config']['totem']['token_retransmits_before_loss_const'] = nil
default['corosync']['config']['totem']['join'] = nil
default['corosync']['config']['totem']['send_join'] = nil
default['corosync']['config']['totem']['consensus'] = nil
default['corosync']['config']['totem']['merge'] = nil
default['corosync']['config']['totem']['downcheck'] = nil
default['corosync']['config']['totem']['fail_recv_const'] = nil
default['corosync']['config']['totem']['seqno_unchanged_const'] = nil
default['corosync']['config']['totem']['heartbeat_failures_allowed'] = nil
default['corosync']['config']['totem']['max_network_delay'] = nil
default['corosync']['config']['totem']['window_size'] = nil
default['corosync']['config']['totem']['max_messages'] = nil
default['corosync']['config']['totem']['miss_count_const'] = nil
default['corosync']['config']['totem']['rrp_problem_count_timeout'] = nil
default['corosync']['config']['totem']['rrp_problem_count_threshold'] = nil
default['corosync']['config']['totem']['rrp_problem_count_mcast_threshold'] = nil
default['corosync']['config']['totem']['rrp_token_expired_timeout'] = nil
default['corosync']['config']['totem']['rrp_autorecovery_check_timeout'] = nil
# Totem interface attributes
default['corosync']['config']['totem']['interface']['ringnumber'] = 0
default['corosync']['config']['totem']['interface']['bindnetaddr'] = nil
default['corosync']['config']['totem']['interface']['broadcast'] = nil
default['corosync']['config']['totem']['interface']['mcastaddr'] = nil
default['corosync']['config']['totem']['interface']['mcastport'] = nil
default['corosync']['config']['totem']['interface']['ttl'] = 1

# Logging attributes
default['corosync']['config']['logging']['fileline'] = 'off'
default['corosync']['config']['logging']['timestamp'] = 'on'
default['corosync']['config']['logging']['function_name'] = 'off'
default['corosync']['config']['logging']['to_logfile'] = 'on'
default['corosync']['config']['logging']['to_syslog'] = 'on'
default['corosync']['config']['logging']['to_stderr'] = 'off'
default['corosync']['config']['logging']['logfile'] = '/var/log/cluster/corosync.log'
default['corosync']['config']['logging']['logfile_priority'] = 'info'
default['corosync']['config']['logging']['syslog_facility'] = 'daemon'
default['corosync']['config']['logging']['syslog_priority'] = 'info'
default['corosync']['config']['logging']['debug'] = 'off'
default['corosync']['config']['logging']['logger_subsys']['subsys'] = 'QUORUM'
default['corosync']['config']['logging']['logger_subsys']['debug'] = 'off'

# Node list
default['corosync']['config']['node_list'] = []

# Quorum attributes
default['corosync']['config']['quorum']['provider'] = 'corosync_votequorum'
default['corosync']['config']['quorum']['expected_votes'] = nil
default['corosync']['config']['quorum']['two_node'] = nil
default['corosync']['config']['quorum']['wait_for_all'] = nil
default['corosync']['config']['quorum']['last_man_standing'] = nil
default['corosync']['config']['quorum']['last_man_standing_window'] = nil
default['corosync']['config']['quorum']['auto_tie_breaker'] = nil
default['corosync']['config']['quorum']['auto_tie_breaker_node'] = nil
default['corosync']['config']['quorum']['allow_downscale'] = nil
default['corosync']['config']['quorum']['expected_votes_tracking'] = nil
