
# 'define' array allows for various environments to be defined as either test or prod
default['patchman']['test']['define'] = []
default['patchman']['prod']['define'] = []

# all nodes default to prod unless otherwise defined for most restrictive patching
# this setting also useful if using chef solo
default['patchman']['environment'] = 'prod'

# day and time attributes should be set in crontab format.
# such as day of week (0 - 6) (Sunday=0), hour/minutes in military time
default['patchman']['test']['cron']['enable'] = true
default['patchman']['test']['day'] = '1'
default['patchman']['test']['time']['hour'] = '5'
default['patchman']['test']['time']['minute'] = '45'

default['patchman']['prod']['cron']['enable'] = true
default['patchman']['prod']['day'] = '3'
default['patchman']['prod']['time']['hour'] = '2'
default['patchman']['prod']['time']['minute'] = '22'

default['patchman']['enable']['email'] = false
default['patchman']['email'] = 'frank@example.com'
default['patchman']['test']['exclude_list'] = ['yum']
default['patchman']['prod']['exclude_list'] = ['kernel*', 'php*']
default['patchman']['test']['auto_reboot'] = false
default['patchman']['prod']['auto_reboot'] = false
default['patchman']['test']['motd_enabled'] = true
default['patchman']['prod']['motd_enabled'] = true

# by default both security and stable updated are ran, setting to true allows security only
default['patchman']['debian']['test']['security_only'] = false
default['patchman']['debian']['prod']['security_only'] = false

default['patchman']['template']['02periodic'] = 'patchman'
default['patchman']['template']['50unattended-upgrades'] = 'patchman'
default['patchman']['template']['92-patch-day-info'] = 'patchman'
default['patchman']['template']['yum-cron'] = 'patchman'
