default['chef_wazuh']['agent']['ossec_conf_path'] = '/var/ossec/etc/ossec.conf'
default['chef_wazuh']['agent']['server'] = nil

default['chef_wazuh']['agent']['ossec_config']['client']['server']['address'] = nil
default['chef_wazuh']['agent']['ossec_config']['client']['server']['port'] = 1514
default['chef_wazuh']['agent']['ossec_config']['client']['server']['protocol'] = 'udp'

default['chef_wazuh']['agent']['ossec_config']['client']['notify_time'] = 60
default['chef_wazuh']['agent']['ossec_config']['client']['time_reconnect'] = 300
default['chef_wazuh']['agent']['ossec_config']['client']['auto_restart'] = true

default['chef_wazuh']['agent']['ossec_config']['client_buffer']['disabled'] = false
default['chef_wazuh']['agent']['ossec_config']['client_buffer']['queue_size'] = 5000
default['chef_wazuh']['agent']['ossec_config']['client_buffer']['events_per_second'] = 500

default['chef_wazuh']['agent']['ossec_config']['rootcheck']['disabled'] = false
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['check_unixaudit'] = true
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['check_files'] = true
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['check_trojans'] = true
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['check_dev'] = true
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['check_sys'] = true
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['check_pids'] = true
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['check_ports'] = true
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['check_if'] = true
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['frequency'] = 43200
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['rootkit_files'] = '/var/ossec/etc/shared/rootkit_files.txt'
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['rootkit_trojans'] = '/var/ossec/etc/shared/rootkit_trojans.txt'
if node['platform'] == 'centos'
  default['chef_wazuh']['agent']['ossec_config']['rootcheck']['system_audits'] = [
      '/var/ossec/etc/shared/system_audit_rcl.txt',
      '/var/ossec/etc/shared/system_audit_ssh.txt',
      '/var/ossec/etc/shared/cis_rhel7_linux_rcl.txt'
  ]
else
  default['chef_wazuh']['agent']['ossec_config']['rootcheck']['system_audits'] = [
      '/var/ossec/etc/shared/system_audit_rcl.txt',
      '/var/ossec/etc/shared/system_audit_ssh.txt'
  ]
end
default['chef_wazuh']['agent']['ossec_config']['rootcheck']['skip_nfs'] = true

default['chef_wazuh']['agent']['ossec_config']['wodle']['open-scap']['disabled'] = true
default['chef_wazuh']['agent']['ossec_config']['wodle']['open-scap']['timeout'] = 1800
default['chef_wazuh']['agent']['ossec_config']['wodle']['open-scap']['interval'] = '1d'
default['chef_wazuh']['agent']['ossec_config']['wodle']['open-scap']['scan_on_start'] = true

case node['platform']
  when 'redhat'
    default['chef_wazuh']['agent']['ossec_config']['wodle']['open-scap']['contents'] = [
        {
            type: 'xccdf',
            path: 'ssg-rhel-7-ds.xml',
            profiles: [
                'xccdf_org.ssgproject.content_profile_pci-dss',
                'xccdf_org.ssgproject.content_profile_common'
            ]
        },
        {
            type: 'xccdf',
            path: 'cve-redhat-7-ds.xml',
            profiles: []
        }
    ]
  when 'centos'
    default['chef_wazuh']['agent']['ossec_config']['wodle']['open-scap']['contents'] = [
        {
            type: 'xccdf',
            path: 'ssg-rhel-7-ds.xml',
            profiles: [
                'xccdf_org.ssgproject.content_profile_pci-dss',
                'xccdf_org.ssgproject.content_profile_common'
            ]
        }
    ]
  when 'ubuntu', 'debian'
    default['chef_wazuh']['agent']['ossec_config']['wodle']['open-scap']['contents'] = nil
end

default['chef_wazuh']['agent']['ossec_config']['wodle']['cis-cat']['disabled'] = true
default['chef_wazuh']['agent']['ossec_config']['wodle']['cis-cat']['timeout'] = 1800
default['chef_wazuh']['agent']['ossec_config']['wodle']['cis-cat']['interval'] = '1d'
default['chef_wazuh']['agent']['ossec_config']['wodle']['cis-cat']['scan_on_start'] = true
default['chef_wazuh']['agent']['ossec_config']['wodle']['cis-cat']['java_path'] = 'wodles/java'
default['chef_wazuh']['agent']['ossec_config']['wodle']['cis-cat']['ciscat_path'] = 'wodles/ciscat'

default['chef_wazuh']['agent']['ossec_config']['syscheck']['disabled'] = false
default['chef_wazuh']['agent']['ossec_config']['syscheck']['frequency'] = 43200
default['chef_wazuh']['agent']['ossec_config']['syscheck']['scan_on_start'] = true
default['chef_wazuh']['agent']['ossec_config']['syscheck']['directories'] = [
    {
        check_all: true,
        content: [
            '/etc',
            '/usr/bin',
            '/usr/sbin'
        ]
    },
    {
        check_all: true,
        content: [
            '/bin',
            '/sbin',
            '/boot'
        ]
    }
]
default['chef_wazuh']['agent']['ossec_config']['syscheck']['ignores'] = [
    '/etc/mtab',
    '/etc/hosts.deny',
    '/etc/mail/statistics',
    '/etc/random-seed',
    '/etc/random.seed',
    '/etc/adjtime',
    '/etc/httpd/logs',
    '/etc/utmpx',
    '/etc/wtmpx',
    '/etc/cups/certs',
    '/etc/dumpdates',
    '/etc/svc/volatile'
]
default['chef_wazuh']['agent']['ossec_config']['syscheck']['nodiff'] = '/etc/ssl/private.key'
default['chef_wazuh']['agent']['ossec_config']['syscheck']['skip_nfs'] = true

default['chef_wazuh']['agent']['ossec_config']['log_analysis']['localfiles'] = [
    {
        log_format: 'command',
        command: 'df -P',
        alias: false,
        frequency: 360
    },
    {
        log_format: 'full_command',
        command: 'netstat -tulpn | sed \'s/\([[:alnum:]]\+\)\ \+[[:digit:]]\+\ \+[[:digit:]]\+\ \+\(.*\):\([[:digit:]]*\)\ \+\([0-9\.\:\*]\+\).\+\ \([[:digit:]]*\/[[:alnum:]\-]*\).*/\1 \2 == \3 == \4 \5/\' | sort -k 4 -g | sed \'s/ == \(.*\) ==/:\1/\' | sed 1,2d',
        alias: 'netstat listening ports',
        frequency: 360
    },
    {
        log_format: 'full_command',
        command: 'last -n 20',
        alias: false,
        frequency: 360
    }
]


default['chef_wazuh']['agent']['ossec_config']['active_response']['disabled'] = false
default['chef_wazuh']['agent']['ossec_config']['active_response']['ca_store'] = '/var/ossec/etc/wpk_root.pem'

default['chef_wazuh']['agent']['ossec_config']['logging']['log_format'] = 'plain'

case node['platform']
  when 'redhat'
    default['chef_wazuh']['agent']['ossec_config']['localfiles'] = [
        {
            log_format: 'audit',
            location: '/var/log/audit/audit.log'
        },
        {
            log_format: 'syslog',
            location: '/var/ossec/logs/active-responses.log'
        },
        {
            log_format: 'syslog',
            location: '/var/log/messages'
        },
        {
            log_format: 'syslog',
            location: '/var/log/secure'
        },
        {
            log_format: 'syslog',
            location: '/var/log/maillog'
        }
    ]
  when 'centos'
    default['chef_wazuh']['agent']['ossec_config']['localfiles'] = [
        {
            log_format: 'apache',
            location: '/var/log/nginx/access.log'
        },
        {
            log_format: 'apache',
            location: '/var/log/nginx/error.log'
        },
        {
            log_format: 'audit',
            location: '/var/log/audit/audit.log'
        },
        {
            log_format: 'syslog',
            location: '/var/ossec/logs/active-responses.log'
        },
        {
            log_format: 'syslog',
            location: '/var/log/messages'
        },
        {
            log_format: 'syslog',
            location: '/var/log/secure'
        },
        {
            log_format: 'syslog',
            location: '/var/log/maillog'
        }
    ]
  when 'ubuntu'
    default['chef_wazuh']['agent']['ossec_config']['localfiles'] = [
        {
            log_format: 'apache',
            location: '/var/log/nginx/access.log'
        },
        {
            log_format: 'apache',
            location: '/var/log/nginx/error.log'
        },
        {
            log_format: 'apache',
            location: '/var/log/apache2/error.log'
        },
        {
            log_format: 'apache',
            location: '/var/log/apache2/access.log'
        },
        {
            log_format: 'syslog',
            location: '/var/ossec/logs/active-responses.log'
        },
        {
            log_format: 'syslog',
            location: '/var/log/auth.log'
        },
        {
            log_format: 'syslog',
            location: '/var/log/syslog'
        },
        {
            log_format: 'syslog',
            location: '/var/log/dpkg.log'
        },
        {
            log_format: 'syslog',
            location: '/var/log/kern.log'
        }
    ]
  when 'debian'
    default['chef_wazuh']['agent']['ossec_config']['localfiles'] = [
        {
            log_format: 'apache',
            location: '/var/log/apache2/error.log'
        },
        {
            log_format: 'apache',
            location: '/var/log/apache2/access.log'
        },
        {
            log_format: 'syslog',
            location: '/var/ossec/logs/active-responses.log'
        },
        {
            log_format: 'syslog',
            location: '/var/log/auth.log'
        },
        {
            log_format: 'syslog',
            location: '/var/log/syslog'
        },
        {
            log_format: 'syslog',
            location: '/var/log/dpkg.log'
        },
        {
            log_format: 'syslog',
            location: '/var/log/kern.log'
        }
    ]
end