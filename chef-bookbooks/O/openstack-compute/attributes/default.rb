# encoding: UTF-8
#
########################################################################
# Toggles - These can be overridden at the environment level
default['enable_monit'] = false # OS provides packages
########################################################################

# Set to some text value if you want templated config files
# to contain a custom banner at the top of the written file
default['openstack']['compute']['custom_template_banner'] = '
# This file is automatically generated by Chef
# Any changes will be overwritten
'

# The name of the Chef role that knows about the message queue server
# that Nova uses
default['openstack']['compute']['rabbit_server_chef_role'] = 'os-ops-messaging'

# Set dbsync command timeout value
default['openstack']['compute']['dbsync_timeout'] = 3600

# The name of the Chef role that sets up the Keystone Service API
default['openstack']['compute']['identity_service_chef_role'] = 'os-identity'

# Disallow non-encrypted connections
default['openstack']['compute']['service_role'] = 'admin'

case node['platform_family']
when 'rhel', 'debian'
  default['openstack']['compute']['user'] = 'nova'
  default['openstack']['compute']['group'] = 'nova'
end

# Logging stuff

default['openstack']['compute']['syslog']['facility'] = 'LOG_LOCAL1'
default['openstack']['compute']['syslog']['config_facility'] = 'local1'

default['openstack']['compute']['region'] = node['openstack']['region']

default['openstack']['compute']['floating_cmd'] = '/usr/local/bin/add_floaters.py'

# rootwrap.conf
default['openstack']['compute']['rootwrap']['filters_path'] = '/etc/nova/rootwrap.d,/usr/share/nova/rootwrap'
default['openstack']['compute']['rootwrap']['exec_dirs'] = '/sbin,/usr/sbin,/bin,/usr/bin'
default['openstack']['compute']['rootwrap']['use_syslog'] = 'False'
default['openstack']['compute']['rootwrap']['syslog_log_facility'] = 'syslog'
default['openstack']['compute']['rootwrap']['syslog_log_level'] = 'ERROR'

default['openstack']['compute']['driver'] = 'libvirt.LibvirtDriver'

# libvirtd_opts used in template for /etc/default/libvirt-bin
default['openstack']['compute']['libvirt']['libvirtd_opts'] = '-l'

default['openstack']['compute']['libvirt']['auth_tcp'] = 'none'
# libvirt.max_clients (default: 20)
default['openstack']['compute']['libvirt']['max_clients'] = 20
# libvirt.max_workers (default: 20)
default['openstack']['compute']['libvirt']['max_workers'] = 20
# libvirt.max_requests (default: 20)
default['openstack']['compute']['libvirt']['max_requests'] = 20
# libvirt.max_client_requests (default: 5)
default['openstack']['compute']['libvirt']['max_client_requests'] = 5
default['openstack']['compute']['libvirt']['group'] = 'libvirt'
default['openstack']['compute']['libvirt']['unix_sock_rw_perms'] = '0770'
default['openstack']['compute']['libvirt']['libvirt_inject_key'] = true
# rbd
default['openstack']['compute']['libvirt']['rbd']['ceph_conf'] = '/etc/ceph/ceph.conf'
# use a different backend for volumes, allowed options: rbd
default['openstack']['compute']['libvirt']['volume_backend'] = nil
default['openstack']['compute']['libvirt']['rbd']['cinder']['pool'] = 'volumes'
default['openstack']['compute']['libvirt']['rbd']['glance']['pool'] = 'images'
default['openstack']['compute']['libvirt']['rbd']['nova']['pool'] = 'instances'
default['openstack']['compute']['libvirt']['rbd']['cinder']['user'] = 'cinder'
default['openstack']['compute']['libvirt']['rbd']['cinder']['secret_uuid'] = '00000000-0000-0000-0000-000000000000'

# Base URL that will be presented to users in links
# to the OpenStack Compute API
default['openstack']['compute']['config']['osapi_compute_link_prefix'] = nil
# Base URL that will be presented to users in links
# to glance resources
default['openstack']['compute']['config']['osapi_glance_link_prefix'] = nil
default['openstack']['compute']['config']['cpu_allocation_ratio'] = 16.0

# `start` will cause nova-compute to error out if a VM is already running, where
# `resume` checks to see if it is running first.
# requires https://review.openstack.org/#/c/8423/
default['openstack']['compute']['config']['resume_guests_state_on_host_boot'] = true

default['openstack']['compute']['ratelimit']['settings'] = {
  'generic-post-limit' => { 'verb' => 'POST', 'uri' => '*', 'regex' => '.*', 'limit' => '10', 'interval' => 'MINUTE' },
  'create-servers-limit' => { 'verb' => 'POST', 'uri' => '*/servers', 'regex' => '^/servers', 'limit' => '50', 'interval' => 'DAY' },
  'generic-put-limit' => { 'verb' => 'PUT', 'uri' => '*', 'regex' => '.*', 'limit' => '10', 'interval' => 'MINUTE' },
  'changes-since-limit' => { 'verb' => 'GET', 'uri' => '*changes-since*', 'regex' => '.*changes-since.*', 'limit' => '3', 'interval' => 'MINUTE' },
  'generic-delete-limit' => { 'verb' => 'DELETE', 'uri' => '*', 'regex' => '.*', 'limit' => '100', 'interval' => 'MINUTE' },
}

# Metering settings
default['openstack']['compute']['metering'] = false ####

# Notification settings
default['openstack']['compute']['config']['notification_topics'] = ['notifications']

if node['openstack']['compute']['metering']
  default['openstack']['compute']['config']['notification_drivers'] = ['nova.openstack.common.notifier.rpc_notifier', 'ceilometer.compute.nova_notifier']
  default['openstack']['compute']['config']['instance_usage_audit'] = 'True'
  default['openstack']['compute']['config']['instance_usage_audit_period'] = 'hour'
  default['openstack']['compute']['config']['notify_on_state_change'] = 'vm_and_task_state'
else
  default['openstack']['compute']['config']['notification_drivers'] = []
  default['openstack']['compute']['config']['instance_usage_audit'] = 'False'
  default['openstack']['compute']['config']['instance_usage_audit_period'] = 'month'
  default['openstack']['compute']['config']['notify_on_state_change'] = ''
end

# Monitor settings
default['openstack']['compute']['config']['compute_available_monitors'] = ['nova.compute.monitors.all_monitors']

# Keystone settings
default['openstack']['compute']['api']['auth_strategy'] = 'keystone'

default['openstack']['compute']['api']['auth']['version'] = node['openstack']['api']['auth']['version']

# A PEM encoded Certificate Authority to use when verifying HTTPs connections.
default['openstack']['compute']['api']['auth']['cafile'] = nil

# Placement API settings
default['openstack']['placement']['ssl']['enabled'] = false
default['openstack']['placement']['ssl']['certfile'] = ''
default['openstack']['placement']['ssl']['chainfile'] = ''
default['openstack']['placement']['ssl']['keyfile'] = ''
default['openstack']['placement']['ssl']['ca_certs_path'] = ''
default['openstack']['placement']['ssl']['cert_required'] = false
default['openstack']['placement']['ssl']['protocol'] = ''
default['openstack']['placement']['ssl']['ciphers'] = ''

# Platform specific settings
case node['platform_family']
when 'rhel' # :pragma-foodcritic: ~FC024 - won't fix this
  default['openstack']['compute']['platform'] = {
    'api_os_compute_packages' => ['openstack-nova-api'],
    'api_os_compute_service' => 'openstack-nova-api',
    'api_placement_packages' => ['openstack-nova-placement-api'],
    'api_placement_service' => 'openstack-nova-placement-api',
    'memcache_python_packages' => ['python-memcached'],
    'compute_api_metadata_packages' => ['openstack-nova-api'],
    'compute_api_metadata_service' => 'openstack-nova-metadata-api',
    'compute_compute_packages' => ['openstack-nova-compute'],
    'qemu_compute_packages' => [],
    'kvm_compute_packages' => [],
    'compute_compute_service' => 'openstack-nova-compute',
    'compute_scheduler_packages' => ['openstack-nova-scheduler'],
    'compute_scheduler_service' => 'openstack-nova-scheduler',
    'compute_conductor_packages' => ['openstack-nova-conductor'],
    'compute_conductor_service' => 'openstack-nova-conductor',
    'compute_vncproxy_packages' => ['openstack-nova-novncproxy'],
    'compute_vncproxy_service' => 'openstack-nova-novncproxy',
    'compute_vncproxy_consoleauth_packages' => ['openstack-nova-console'],
    'compute_vncproxy_consoleauth_service' => 'openstack-nova-consoleauth',
    'compute_serialproxy_packages' => ['openstack-nova-serialproxy'],
    'compute_serialproxy_service' => 'openstack-nova-serialproxy',
    'libvirt_packages' => ['libvirt', 'device-mapper', 'python-libguestfs'],
    'libvirt_service' => 'libvirtd',
    'libvirt_ceph_packages' => ['ceph-common'],
    'dbus_service' => 'messagebus',
    'compute_cert_packages' => ['openstack-nova-cert'],
    'compute_cert_service' => 'openstack-nova-cert',
    'mysql_service' => 'mysqld',
    'common_packages' => ['openstack-nova-common'],
    'iscsi_helper' => 'ietadm',
    'volume_packages' => ['sysfsutils', 'sg3_utils', 'device-mapper-multipath'],
    'package_overrides' => '',
  }
when 'debian'
  default['openstack']['compute']['platform'] = {
    'api_os_compute_packages' => ['nova-api-os-compute'],
    'api_os_compute_service' => 'nova-api-os-compute',
    'api_placement_packages' => ['nova-placement-api'],
    'api_placement_service' => 'nova-placement-api',
    'memcache_python_packages' => ['python-memcache'],
    'compute_api_metadata_packages' => ['nova-api-metadata'],
    'compute_api_metadata_service' => 'nova-api-metadata',
    'compute_compute_packages' => ['nova-compute'],
    'qemu_compute_packages' => ['nova-compute-qemu'],
    'kvm_compute_packages' => ['nova-compute-kvm'],
    'compute_compute_service' => 'nova-compute',
    'compute_scheduler_packages' => ['nova-scheduler'],
    'compute_scheduler_service' => 'nova-scheduler',
    'compute_conductor_packages' => ['nova-conductor'],
    'compute_conductor_service' => 'nova-conductor',
    # Websockify is needed due to https://bugs.launchpad.net/ubuntu/+source/nova/+bug/1076442
    'compute_vncproxy_packages' => ['novnc', 'websockify', 'nova-novncproxy'],
    'compute_vncproxy_service' => 'nova-novncproxy',
    'compute_vncproxy_consoleauth_packages' => ['nova-consoleauth'],
    'compute_vncproxy_consoleauth_service' => 'nova-consoleauth',
    'compute_serialproxy_packages' => ['nova-serialproxy'],
    'compute_serialproxy_service' => 'nova-serialproxy',
    'libvirt_packages' => ['libvirt-bin', 'python-guestfs'],
    'libvirt_service' => 'libvirt-bin',
    'libvirt_ceph_packages' => ['ceph-common'],
    'dbus_service' => 'dbus',
    'compute_cert_packages' => ['nova-cert'],
    'compute_cert_service' => 'nova-cert',
    'mysql_service' => 'mysql',
    'common_packages' => ['nova-common'],
    'iscsi_helper' => 'tgtadm',
    'volume_packages' => ['sysfsutils', 'sg3-utils', 'multipath-tools'],
    'package_overrides' => '',
  }
end

# Array of options for `api-paste.ini` (e.g. ['option1=value1', ...])
default['openstack']['compute']['misc_paste'] = nil

# NOTE: The metadata api service is enabled via including it's recipe
# NOTE: api-metadata.  By default the api-metadata recipe is included in
# NOTE: the os-compute-api role which is included in the
# NOTE: os-compute-single-controller role.

# For true case, this logic allows the following ironic-related attribtes to be overwritten automatically.

# ****************** OpenStack Compute Endpoints ******************************

# The OpenStack Compute (Nova) XVPvnc endpoint
%w(
  compute-xvpvnc compute-novnc
  compute-metadata-api
  compute-vnc compute-api
).each do |service|
  default['openstack']['bind_service']['all'][service]['host'] = '127.0.0.1'
  %w(public internal admin).each do |type|
    default['openstack']['endpoints'][type][service]['host'] = '127.0.0.1'
    default['openstack']['endpoints'][type][service]['scheme'] = 'http'
  end
end
%w(public internal admin).each do |type|
  default['openstack']['endpoints'][type]['compute-xvpvnc']['port'] = '6081'
  default['openstack']['endpoints'][type]['compute-xvpvnc']['path'] = '/console'
  # The OpenStack Compute (Nova) Native API endpoint
  default['openstack']['endpoints'][type]['compute-api']['port'] = '8774'
  default['openstack']['endpoints'][type]['compute-api']['path'] = '/v2.1/%(tenant_id)s'
  # The OpenStack Compute (Nova) novnc endpoint
  default['openstack']['endpoints'][type]['compute-novnc']['port'] = '6080'
  default['openstack']['endpoints'][type]['compute-novnc']['path'] = '/vnc_auto.html'
  # The OpenStack Compute (Nova) metadata API endpoint
  default['openstack']['endpoints'][type]['compute-metadata-api']['port'] = '8775'
  # The OpenStack Compute (Nova) serial proxy endpoint
  default['openstack']['endpoints'][type]['compute-serial-proxy']['scheme'] = 'ws'
  default['openstack']['endpoints'][type]['compute-serial-proxy']['port'] = '6083'
  default['openstack']['endpoints'][type]['compute-serial-proxy']['path'] = '/'
  default['openstack']['endpoints'][type]['compute-serial-proxy']['host'] = '127.0.0.1'
  # The OpenStack Compute (Nova) Placement API endpoint
  default['openstack']['endpoints'][type]['placement-api']['port'] = '8778'
  default['openstack']['endpoints'][type]['placement-api']['path'] = ''
  default['openstack']['endpoints'][type]['placement-api']['host'] = '127.0.0.1'
end
default['openstack']['bind_service']['all']['compute-serial-proxy']['host'] = '127.0.0.1'
default['openstack']['bind_service']['all']['compute-vnc-proxy']['host'] = '127.0.0.1'
default['openstack']['bind_service']['all']['compute-serial-console']['host'] = '127.0.0.1'
default['openstack']['bind_service']['all']['compute-xvpvnc']['port'] = '6081'
default['openstack']['bind_service']['all']['compute-vnc']['port'] = '6081'
default['openstack']['bind_service']['all']['compute-serial-proxy']['port'] = '6081'
default['openstack']['bind_service']['all']['compute-novnc']['port'] = '6080'
default['openstack']['bind_service']['all']['compute-metadata-api']['port'] = '8775'
default['openstack']['bind_service']['all']['compute-api']['port'] = '8774'
default['openstack']['bind_service']['all']['placement-api']['port'] = '8778'
default['openstack']['bind_service']['all']['placement-api']['host'] = '127.0.0.1'
