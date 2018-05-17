default["ossec"]["version"] = "2.8"
default["ossec"]["syslog_output"]["ip"] = "172.16.254.254"
default["ossec"]["syslog_output"]["port"] = "514"
default["ossec"]["syslog_output"]["min_level"] = "5"
default["ossec"]["receiver_port"] = "1514"
default["ossec"]["log_alert_level"] = "1"
default["ossec"]["email_alert_level"] = "7"
default["ossec"]["email_maxperhour"] = "9999"
default["ossec"]["email_idsname"] = "ossec"
default["ossec"]["memory_size"] = "100000"
default["ossec"]["remote"]["connection"] = "secure"
default["ossec"]["agents"] = {}
default["ossec"]["rules"] = {}
default["ossec"]["email_alerts"] = {}
if node["roles"].include?("ossec-server")
  default["ossec"]["agent"]["enable"] = false
else
  default["ossec"]["agent"]["enable"] = true
end

if platform_family?('debian')
  default["ossec"]["server"]["service_name"] = "ossec-hids-server"
  default["ossec"]["client"]["service_name"] = "ossec-hids-client"
elsif platform_family?('rhel')
  default["ossec"]["server"]["service_name"] = "ossec-hids"
  default["ossec"]["client"]["service_name"] = "ossec-hids"
end

# Sane defaults for each distribution platform for syslog files
if platform_family?('debian')
  default["ossec"]["syslog_files"]["/var/log/auth.log"] = {}
  default["ossec"]["syslog_files"]["/var/log/daemon.log"] = {}
  default["ossec"]["syslog_files"]["/var/log/kern.log"] = {}
  default["ossec"]["syslog_files"]["/var/log/mail.log"] = {}
  default["ossec"]["syslog_files"]["/var/log/syslog"] = {}
  default["ossec"]["syslog_files"]["/var/log/user.log"] = {}
  default["ossec"]["syslog_files"]["/var/log/chef/client.log"] = {}

elsif platform_family?('rhel')
  default["ossec"]["syslog_files"]["/var/log/cron"] = {}
  default["ossec"]["syslog_files"]["/var/log/dmesg"] = {}
  default["ossec"]["syslog_files"]["/var/log/maillog"] = {}
  default["ossec"]["syslog_files"]["/var/log/messages"] = {}
  default["ossec"]["syslog_files"]["/var/log/secure"] = {}
  default["ossec"]["syslog_files"]["/var/log/spooler"] = {}
  default["ossec"]["syslog_files"]["/var/log/yum.log"] = {}
  default["ossec"]["syslog_files"]["/var/log/chef/client.log"] = {}
end

# Sane defaults for syscheck
default["ossec"]["syscheck"]["frequency"] = '7200'
default["ossec"]["syscheck"]["alert_new_files"] = 'yes'
default["ossec"]["syscheck"]["auto_ignore"] = 'no'

default["ossec"]["syscheck"]["directories"]['/bin'] = {
  'report_changes' => 'no',
  'realtime' => 'yes'
}
default["ossec"]["syscheck"]["directories"]['/boot'] = {
  'report_changes' => 'no',
  'realtime' => 'no'
}
default["ossec"]["syscheck"]["directories"]['/etc'] = {
  'report_changes' => 'yes',
  'realtime' => 'no'
}
default["ossec"]["syscheck"]["directories"]['/lib/lsb'] = {
  'report_changes' => 'no',
  'realtime' => 'yes'
}
default["ossec"]["syscheck"]["directories"]['/lib/modules'] = {
  'report_changes' => 'no',
  'realtime' => 'yes'
}
default["ossec"]["syscheck"]["directories"]['/lib/plymouth'] = {
  'report_changes' => 'no',
  'realtime' => 'yes'
}
default["ossec"]["syscheck"]["directories"]['/lib/security'] = {
  'report_changes' => 'no',
  'realtime' => 'yes'
}
default["ossec"]["syscheck"]["directories"]['/lib/terminfo'] = {
  'report_changes' => 'no',
  'realtime' => 'yes'
}
default["ossec"]["syscheck"]["directories"]['/lib/ufw'] = {
  'report_changes' => 'no',
  'realtime' => 'yes'
}
default["ossec"]["syscheck"]["directories"]['/lib/xtables'] = {
  'report_changes' => 'no',
  'realtime' => 'no'
}
default["ossec"]["syscheck"]["directories"]['/media'] = {
  'report_changes' => 'no',
  'realtime' => 'no'
}
default["ossec"]["syscheck"]["directories"]['/opt'] = {
  'report_changes' => 'no',
  'realtime' => 'no'
}
default["ossec"]["syscheck"]["directories"]['/root'] = {
  'report_changes' => 'yes',
  'realtime' => 'no'
}
default["ossec"]["syscheck"]["directories"]['/srv'] = {
  'report_changes' => 'no',
  'realtime' => 'no'
}
default["ossec"]["syscheck"]["directories"]['/sbin'] = {
  'report_changes' => 'no',
  'realtime' => 'yes'
}
default["ossec"]["syscheck"]["directories"]['/usr/'] = {
  'report_changes' => 'yes',
  'realtime' => 'yes'
}
default["ossec"]["syscheck"]["directories"]['/tmp'] = {
  'report_changes' => 'no',
  'realtime' => 'no'
}

# Syscheck Ignore Files
default["ossec"]["syscheck"]["ignore"]['/etc/openvpn/openvpn-status.log'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/motd'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/blkid.tab'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/mtab'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/hosts.deny'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/mail/statistics'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/random-seed'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/adjtime'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/prelink.cache'] = {}
default["ossec"]["syscheck"]["ignore"]['/root/.bash_history'] = {}
default["ossec"]["syscheck"]["ignore"]['/root/.viminfo'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/dnscache/stats'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/dnscache/log'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/dnscache2/stats'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/dnscache2/log'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/tinydns/stats'] = {}
default["ossec"]["syscheck"]["ignore"]['/etc/tinydns/log'] = {}

# Commands
default["ossec"]["command"]["host-deny"]["enabled"] = false
default["ossec"]["command"]["host-deny"]["executable"] = 'host-deny.sh'
default["ossec"]["command"]["host-deny"]["expect"] = 'srcip'
default["ossec"]["command"]["host-deny"]["timeout_allowed"] = 'yes'

default["ossec"]["command"]["firewall-stop"]["enabled"] = true
default["ossec"]["command"]["firewall-stop"]["executable"] = 'firewall-drop.sh'
default["ossec"]["command"]["firewall-stop"]["expect"] = 'srcip'
default["ossec"]["command"]["firewall-stop"]["timeout_allowed"] = 'yes'

default["ossec"]["command"]["disable-account"]["enabled"] = false
default["ossec"]["command"]["disable-account"]["executable"] = 'disable-account.sh'
default["ossec"]["command"]["disable-account"]["expect"] = 'user'
default["ossec"]["command"]["disable-account"]["timeout_allowed"] = 'yes'

default["ossec"]["local_command"] = {}

# Active-Responses
default["ossec"]["active-response"]["host-deny"]["enabled"] = true
default["ossec"]["active-response"]["host-deny"]["location"] = 'local'
default["ossec"]["active-response"]["host-deny"]["level"] = '10'
default["ossec"]["active-response"]["host-deny"]["timeout"] = '600'

default["ossec"]["active-response"]["firewall-stop"]["enabled"] = true
default["ossec"]["active-response"]["firewall-stop"]["location"] = 'local'
default["ossec"]["active-response"]["firewall-stop"]["level"] = '10'
default["ossec"]["active-response"]["firewall-stop"]["timeout"] = '600'

default["ossec"]["active-response"]["disable-account"]["enabled"] = false
default["ossec"]["active-response"]["disable-account"]["location"] = 'local'
default["ossec"]["active-response"]["disable-account"]["level"] = '10'
default["ossec"]["active-response"]["disable-account"]["timeout"] = '600'


# internal options, you probably don't want to touch that
default["ossec"]["internal"]["analysisd"]["default_timeframe"] = "360"
default["ossec"]["internal"]["analysisd"]["stats_maxdiff"] = "25000"
default["ossec"]["internal"]["analysisd"]["stats_mindiff"] = "250"
default["ossec"]["internal"]["analysisd"]["stats_percent_diff"] = "30"
default["ossec"]["internal"]["analysisd"]["fts_list_size"] = "32"
default["ossec"]["internal"]["analysisd"]["fts_min_size_for_str"] = "14"
default["ossec"]["internal"]["analysisd"]["log_fw"] = "1"
default["ossec"]["internal"]["logcollector"]["loop_timeout"] = "2"
default["ossec"]["internal"]["logcollector"]["open_attempts"] = "8"
default["ossec"]["internal"]["logcollector"]["remote_commands"] = 1
default["ossec"]["internal"]["remoted"]["recv_counter_flush"] = "128"
default["ossec"]["internal"]["remoted"]["comp_average_printout"] = "19999"
default["ossec"]["internal"]["remoted"]["verify_msg_id"] = "1"
default["ossec"]["internal"]["maild"]["strict_checking"] = "1"
default["ossec"]["internal"]["maild"]["groupping"] = "0"
default["ossec"]["internal"]["maild"]["full_subject"] = "1"
default["ossec"]["internal"]["maild"]["geoip"] = "1"
default["ossec"]["internal"]["monitord"]["compress"] = "1"
default["ossec"]["internal"]["monitord"]["sign"] = "1"
default["ossec"]["internal"]["monitord"]["monitor_agents"] = "1"
default["ossec"]["internal"]["syscheck"]["sleep"] = "2"
default["ossec"]["internal"]["syscheck"]["sleep_after"] = "15"
default["ossec"]["internal"]["dbd"]["reconnect_attempts"] = "10"
default["ossec"]["internal"]["window"]["debug"] = "0"
default["ossec"]["internal"]["syscheck"]["debug"] = "0"
default["ossec"]["internal"]["remoted"]["debug"] = "0"
default["ossec"]["internal"]["analysisd"]["debug"] = "0"
default["ossec"]["internal"]["logcollector"]["debug"] = "0"
default["ossec"]["internal"]["agent"]["debug"] = "0"

# What OSSEC fules files to load
default["ossec"]["load_rules"] = {
  'rules_config.xml'		=> true,
  'pam_rules.xml'		=> true,
  'sshd_rules.xml'		=> true,
  'telnetd_rules.xml'		=> false,
  'syslog_rules.xml'		=> true,
  'arpwatch_rules.xml'		=> true,
  'symantec-av_rules.xml'	=> false,
  'symantec-ws_rules.xml'	=> false,
  'pix_rules.xml'		=> false,
  'named_rules.xml'		=> true,
  'smbd_rules.xml'		=> true,
  'vsftpd_rules.xml'		=> false,
  'pure-ftpd_rules.xml'		=> false,
  'proftpd_rules.xml'		=> false,
  'ms_ftpd_rules.xml'		=> false,
  'ftpd_rules.xml'		=> false,
  'hordeimp_rules.xml'		=> false,
  'roundcube_rules.xml'		=> false,
  'wordpress_rules.xml'		=> false,
  'cimserver_rules.xml'		=> false,
  'vpopmail_rules.xml'		=> false,
  'vmpop3d_rules.xml'		=> false,
  'courier_rules.xml'		=> false,
  'web_rules.xml'		=> true,
  'web_appsec_rules.xml'	=> true,
  'apache_rules.xml'		=> true,
  'nginx_rules.xml'		=> true,
  'php_rules.xml'		=> true,
  'mysql_rules.xml'		=> true,
  'postgresql_rules.xml'	=> true,
  'ids_rules.xml'		=> true,
  'squid_rules.xml'		=> false,
  'firewall_rules.xml'		=> true,
  'cisco-ios_rules.xml'		=> false,
  'netscreenfw_rules.xml'	=> false,
  'sonicwall_rules.xml'		=> false,
  'postfix_rules.xml'		=> true,
  'sendmail_rules.xml'		=> false,
  'imapd_rules.xml'		=> false,
  'mailscanner_rules.xml'	=> false,
  'dovecot_rules.xml'		=> false,
  'ms-exchange_rules.xml'	=> false,
  'racoon_rules.xml'		=> false,
  'vpn_concentrator_rules.xml'	=> false,
  'spamd_rules.xml'		=> false,
  'msauth_rules.xml'		=> false,
  'clam_av_rules.xml'		=> true,
  'mcafee_av_rules.xml'		=> false,
  'trend-osce_rules.xml'	=> false,
  'ms-se_rules.xml'		=> false,
  'zeus_rules.xml'		=> false,
  'solaris_bsm_rules.xml'	=> false,
  'vmware_rules.xml'		=> false,
  'ms_dhcp_rules.xml'		=> false,
  'asterisk_rules.xml'		=> false,
  'ossec_rules.xml'		=> true,
  'attack_rules.xml'		=> true,
  'local_rules.xml'		=> true,
}
