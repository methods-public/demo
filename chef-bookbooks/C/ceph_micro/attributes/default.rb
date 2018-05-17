default['ceph_micro']['version'] = 'giant'
default['ceph_micro']['path'] = '/tmp/micro-ceph'
if platform_family?("rhel")
  default['ceph_micro']['librados'] = 'librados2'
  default['ceph_micro']['librbd'] = 'librbd1'
  default['ceph_micro']['ceph-includes'] = 'ceph-devel'
else
  default['ceph_micro']['librados'] = 'librados-dev'
  default['ceph_micro']['librbd'] = 'librbd-dev'
end
