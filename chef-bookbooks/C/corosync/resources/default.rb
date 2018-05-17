#
# Cookbook Name:: corosync
# Resource:: corosync_default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#

actions :create
default_action :create

# Corosync.conf directives
state_attrs :totem_version

# Totem attributes
attribute :totem_version, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['version']
attribute :totem_crypto_cipher, equal_to: [:none, 'none', \
                                           :aes256, 'aes256', \
                                           :aes192, 'aes192', \
                                           :aes128, 'aes128', \
                                           :des, '3des'], default: node['corosync']['config']['totem']['crypto_cipher']
attribute :totem_crypto_hash, equal_to: [:none, 'none', \
                                         :md5, 'md5', \
                                         :sha1, 'sha1', \
                                         :sha256, 'sha256', \
                                         :sha384, 'sha384', \
                                         :sha512, 'sha512'], default: node['corosync']['config']['totem']['crypto_hash']
attribute :totem_secauth, equal_to: [:on, 'on', :off, 'off'], default: node['corosync']['config']['totem']['secauth']
attribute :totem_transport, equal_to: [:udp, 'udp', :udpu, 'udpu', :iba, 'iba'], default: node['corosync']['config']['totem']['transport']
attribute :totem_rrp_mode, equal_to: [:none, 'none', :active, 'active', :passive, 'passive'], default: node['corosync']['config']['totem']['rrp_mode']
attribute :totem_netmtu, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['netmtu']
attribute :totem_cluster_name, kind_of: [String, nil], default: node['corosync']['config']['totem']['cluster_name']
attribute :totem_config_version, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['config_version']
attribute :totem_ip_version, equal_to: [:ipv4, 'ipv4', :ipv6, 'ipv6'], default: node['corosync']['config']['totem']['ip_version']
attribute :totem_token, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['token']
attribute :totem_token_coefficient, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['token_coefficient']
attribute :totem_token_retransmit, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['token_retransmit']
attribute :totem_hold, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['hold']
attribute :totem_token_retransmits_before_loss_const, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['token_retransmits_before_loss_const']
attribute :totem_join, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['join']
attribute :totem_send_join, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['send_join']
attribute :totem_consensus, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['consensus']
attribute :totem_merge, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['merge']
attribute :totem_downcheck, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['downcheck']
attribute :totem_fail_recv_const, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['fail_recv_const']
attribute :totem_seqno_unchanged_const, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['seqno_unchanged_const']
attribute :totem_heartbeat_failures_allowed, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['heartbeat_failures_allowed']
attribute :totem_max_network_delay, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['max_network_delay']
attribute :totem_window_size, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['window_size']
attribute :totem_max_messages, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['max_messages']
attribute :totem_miss_count_const, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['miss_count_const']
attribute :totem_rrp_problem_count_timeout, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['rrp_problem_count_timeout']
attribute :totem_rrp_problem_count_threshold, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['rrp_problem_count_threshold']
attribute :totem_rrp_problem_count_mcast_threshold, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['rrp_problem_count_mcast_threshold']
attribute :totem_rrp_token_expired_timeout, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['rrp_token_expired_timeout']
attribute :totem_rrp_autorecovery_check_timeout, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['rrp_autorecovery_check_timeout']

# Totem interface
attribute :totem_interface_ringnumber, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['interface']['ringnumber']
attribute :totem_interface_bindnetaddr, kind_of: [String, nil], default: node['corosync']['config']['totem']['interface']['bindnetaddr']
attribute :totem_interface_broadcast, equal_to: [:on, 'yes', :off, 'no'], default: node['corosync']['config']['totem']['interface']['broadcast']
attribute :totem_interface_mcastaddr, kind_of: [String, nil], default: node['corosync']['config']['totem']['interface']['mcastaddr']
attribute :totem_interface_mcastport, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['interface']['mcastport']
attribute :totem_interface_ttl, kind_of: [Integer, nil], default: node['corosync']['config']['totem']['interface']['ttl']

# Logging attributes
attribute :log_fileline, equal_to: [:on, 'on', :off, 'off'], default: node['corosync']['config']['logging']['fileline']
attribute :log_timestamp, equal_to: [:on, 'on', :off, 'off'], default: node['corosync']['config']['logging']['timestamp']
attribute :log_function_name, equal_to: [:on, 'on', :off, 'off'], default: node['corosync']['config']['logging']['function_name']
attribute :log_to_logfile, equal_to: [:on, 'on', :off, 'off'], default: node['corosync']['config']['logging']['to_logfile']
attribute :log_to_syslog, equal_to: [:on, 'on', :off, 'off'], default: node['corosync']['config']['logging']['to_syslog']
attribute :log_to_stderr, equal_to: [:on, 'on', :off, 'off'], default: node['corosync']['config']['logging']['to_stderr']
attribute :log_logfile, kind_of: [String, nil], default: node['corosync']['config']['logging']['logfile']
attribute :log_debug, equal_to: [:on, 'on', :off, 'off'], default: node['corosync']['config']['logging']['debug']
attribute :log_logfile_priority, equal_to: [:alert, 'alert', \
                                            :crit, 'crit', \
                                            :debug, 'debig', \
                                            :emerg, 'emerg', \
                                            :err, 'err', \
                                            :info, 'info', \
                                            :notice, 'notice', \
                                            :warning, 'warning'], default: node['corosync']['config']['logging']['logfile_priority']
attribute :log_syslog_facility, equal_to: [:daemon, 'daemon', \
                                           :local0, 'local0', \
                                           :local1, 'local1', \
                                           :local2, 'local2', \
                                           :local3, 'local3', \
                                           :local4, 'local4', \
                                           :local5, 'local5', \
                                           :local6, 'local6', \
                                           :local7, 'local7'], default: node['corosync']['config']['logging']['syslog_facility']
attribute :log_syslog_priority, equal_to: [:alert, 'alert', \
                                           :crit, 'crit', \
                                           :debug, 'debig', \
                                           :emerg, 'emerg', \
                                           :err, 'err', \
                                           :info, 'info', \
                                           :notice, 'notice', \
                                           :warning, 'warning'], default: node['corosync']['config']['logging']['syslog_priority']
attribute :log_logger_subsys, kind_of: [String, nil], default: node['corosync']['config']['logging']['logger_subsys']['subsys']
attribute :log_logger_subsys_debug, equal_to: [:on, 'on', :off, 'off'], default: node['corosync']['config']['logging']['logger_subsys']['debug']

# Node list attributes
attribute :node_list # Expect the following structure: [{'ring: Int', 'node_name: String', 'ip_addr: String'}]

# Quorum attributes
attribute :quorum_provider, kind_of: [String, nil], default: node['corosync']['config']['quorum']['provider']
attribute :quorum_expected_votes, kind_of: [Integer, nil], default: node['corosync']['config']['quorum']['expected_votes']
attribute :quorum_two_node, kind_of: [Integer, nil], default: node['corosync']['config']['quorum']['two_node']
attribute :quorum_wait_for_all, kind_of: [Integer, nil], default: node['corosync']['config']['quorum']['wait_for_all']
attribute :quorum_last_man_standing, kind_of: [Integer, nil], default: node['corosync']['config']['quorum']['last_man_standing']
attribute :quorum_last_man_standing_window, kind_of: [Integer, nil], default: node['corosync']['config']['quorum']['last_man_standing_window']
attribute :quorum_expected_votes, kind_of: [Integer, nil], default: node['corosync']['config']['quorum']['expected_votes']
attribute :quorum_auto_tie_breaker, kind_of: [Integer, nil], default: node['corosync']['config']['quorum']['auto_tie_breaker']
attribute :quorum_auto_tie_breaker_node, kind_of: [String, nil], default: node['corosync']['config']['quorum']['auto_tie_breaker_node']
attribute :quorum_allow_downscale, kind_of: [Integer, nil], default: node['corosync']['config']['quorum']['allow_downscale']
attribute :quorum_expected_votes_tracking, kind_of: [Integer, nil], default: node['corosync']['config']['quorum']['expected_votes_tracking']
