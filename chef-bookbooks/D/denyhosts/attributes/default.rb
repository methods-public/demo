#
# Cookbook Name:: denyhosts
# Recipe:: default
#
# Copyright 2012-2014, North County Tech Center, LLC
#
# All rights reserved - Do Not Redistribute
#

default['denyhosts']['config'] = {
"SECURE_LOG" => "/var/log/secure",
"HOSTS_DENY" => "/etc/hosts.deny",
"PURGE_DENY" => "4w",
"PURGE_THRESHOLD" => "2",
"BLOCK_SERVICE" => "sshd",
"DENY_THRESHOLD_INVALID" => "5",
"DENY_THRESHOLD_VALID" => "10",
"DENY_THRESHOLD_ROOT" => "1",
"DENY_THRESHOLD_RESTRICTED" => "1",
"WORK_DIR" => "/var/lib/denyhosts",
"SUSPICIOUS_LOGIN_REPORT_ALLOWED_HOSTS" => "YES",
"HOSTNAME_LOOKUP" => "YES",
"LOCK_FILE" => "/var/lock/subsys/denyhosts",
"ADMIN_EMAIL" => "root",
"SMTP_HOST" => "localhost",
"SMTP_PORT" => "25",
#SMTP_USERNAME=foo,
#SMTP_PASSWORD=bar,
"SMTP_FROM" => "DenyHosts <nobody@localhost>",
"SMTP_SUBJECT" => "DenyHosts Report from $[HOSTNAME]",
#SMTP_DATE_FORMAT = %a, %d %b %Y %H:%M:%S %z
"SYSLOG_REPORT" => "YES",
#ALLOWED_HOSTS_HOSTNAME_LOOKUP=NO
"AGE_RESET_VALID" => "5d",
"AGE_RESET_ROOT" => "25d",
"AGE_RESET_RESTRICTED" => "25d",
"AGE_RESET_INVALID" => "10d",
#RESET_ON_SUCCESS = yes
#PLUGIN_DENY=/usr/bin/true
#PLUGIN_PURGE=/usr/share/denyhosts/plugins/restorecon.sh
#USERDEF_FAILED_ENTRY_REGEX=
"DAEMON_LOG" => "/var/log/denyhosts",
#DAEMON_LOG_MESSAGE_FORMAT = %(asctime)s - %(name)-12s: %(levelname)-8s %(message)s
"DAEMON_SLEEP" => "30s",
"DAEMON_PURGE" => "1h"
#SYNC_SERVER = http://xmlrpc.denyhosts.net:9911
#SYNC_INTERVAL = 1h
#SYNC_UPLOAD = no
#SYNC_UPLOAD = yes
#SYNC_DOWNLOAD = no
#SYNC_DOWNLOAD = yes
#SYNC_DOWNLOAD_THRESHOLD = 10
}

default['denyhosts']['allowed-hosts'] = [
]

