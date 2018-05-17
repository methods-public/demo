default['yum']['atomic-testing']['repositoryid'] = 'atomic-testing'
default['yum']['atomic-testing']['gpgkey'] = %w(https://www.atomicorp.com/RPM-GPG-KEY.art.txt https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt)
default['yum']['atomic-testing']['gpgcheck'] = true
default['yum']['atomic-testing']['enabled'] = false
default['yum']['atomic-testing']['managed'] = false

case node['platform']
when 'fedora'
  default['yum']['atomic-testing']['mirrorlist'] = 'https://updates.atomicorp.com/channels/mirrorlist/atomic-testing/fedora-$releasever-$basearch'
  default['yum']['atomic-testing']['description'] = 'Fedora Core $releasever - atomicrocketturtle.com - (Testing)'
when 'redhat', 'centos', 'scientific'
  default['yum']['atomic-testing']['mirrorlist'] = 'https://updates.atomicorp.com/channels/mirrorlist/atomic-testing/centos-$releasever-$basearch'
  default['yum']['atomic-testing']['description'] = 'CentOS / Red Hat Enterprise Linux $releasever - atomicrocketturtle.com - (Testing)'
end
