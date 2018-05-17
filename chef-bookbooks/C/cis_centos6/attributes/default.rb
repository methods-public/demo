default['cis_centos6']['additional_security']['selinux']['enabled'] = true

default['cis_centos6']['additional_security']['yum']['exclude'] = ''

default['cis_centos6']['banners']['content'] = 'Authorized uses only. All activity may be monitored and reported.
'

default['cis_centos6']['environment']['login']['pass_max_days'] = 90
default['cis_centos6']['environment']['login']['pass_min_days'] = 7
default['cis_centos6']['environment']['login']['pass_warn_age'] = 7

default['cis_centos6']['environment']['system_accounts_requiring_shell'] = []

default['cis_centos6']['environment']['lock_inactive_user_accounts'] = true

default['cis_centos6']['logging']['auditd']['max_log_size'] = 20
default['cis_centos6']['logging']['auditd']['disable_system_on_audit_log_full'] = true

default['cis_centos6']['special_purpose_services']['ntp']['servers'] = [
	'0.centos.pool.ntp.org',
	'1.centos.pool.ntp.org',
	'2.centos.pool.ntp.org',
	'3.centos.pool.ntp.org'
]

default['cis_centos6']['special_purpose_services']['disable_nfs_and_rpc'] = true

default['cis_centos6']['pam']['enable_pam_limits'] = false

default_unless['cis_centos6']['sshd_config']['allow_users'] = []
default_unless['cis_centos6']['sshd_config']['deny_users'] = []
default_unless['cis_centos6']['sshd_config']['deny_groups'] = []
default_unless['cis_centos6']['sshd_config']['allow_groups'] = []

default['cis_centos6']['sshd_config']['ciphers'] = ['aes128-ctr','aes192-ctr','aes256-ctr']
default['cis_centos6']['sshd_config']['macs'] = []

default['cis_centos6']['filesystem']['tmp']['options'] = ['defaults','nodev','nosuid','noexec']
