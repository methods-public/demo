# Main
# Number of seconds to wait between checks for available updates. 
default['yum-updatesd']['run_interval'] = 3600
# Minimum number of seconds between update information refreshes to avoid hitting the server too often. 
default['yum-updatesd']['updaterefresh'] = 600
# List of ways to emit update notification. Valid values are 'email', 'dbus' and 'syslog'. 
default['yum-updatesd']['emit_via'] = 'syslog'
# Boolean option to decide whether or not updates should be automatically applied. Defaults to False. 
default['yum-updatesd']['do_update'] = false
# Boolean option to decide whether or not updates should be automatically downloaded. Defaults to False. 
default['yum-updatesd']['do_download'] = false
# Boolean option to automatically download dependencies of packages which need updating as well. Defaults to False. 
default['yum-updatesd']['do_download_deps'] = false
# Boolen option to listen via dbus to give out update information/check for new updates
default['dbus_listener']['do_download_deps'] = false

# Mail Options
# List of email addresses to send update notification to. Defaults to 'root@localhost'. 
default['yum-updatesd']['email_to'] = 'root@localhost'
# Email address for update notifications to be from. Defaults to 'yum-updatesd@localhost'. 
default['yum-updatesd']['email_from'] = 'yum-updatesd@localhost'
# SMTP server to use when sending mail, host or a host:port string. Defaults to 'localhost:25'. 
default['yum-updatesd']['smtp_server'] = 'localhost:25'

# Syslog Options
# What syslog facility should be used. Defaults to 'DAEMON'. 
default['yum-updatesd']['syslog_facility'] = 'DAEMON'
# Level of syslog messages. Defaults to 'WARN'. 
default['yum-updatesd']['syslog_level'] =  'WARN'