default['yum']['jpackage']['repositoryid'] = 'jpackage'

case node['platform']
when 'amazon'
  default['yum']['jpackage']['description'] = 'JPackage 6 generic'
  default['yum']['jpackage']['mirrorlist'] = 'http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=6.0'
  default['yum']['jpackage']['gpgkey'] = 'http://www.jpackage.org/jpackage.asc'
else
  case node['platform_version'].to_i
  when 5
    default['yum']['jpackage']['description'] = 'JPackage 5 generic'
    default['yum']['jpackage']['mirrorlist'] = 'http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=5.0'
    default['yum']['jpackage']['gpgkey'] = 'http://www.jpackage.org/jpackage.asc'
  when 6
    default['yum']['jpackage']['description'] = 'JPackage 6 generic'
    default['yum']['jpackage']['mirrorlist'] = 'http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=6.0'
    default['yum']['jpackage']['gpgkey'] = 'http://www.jpackage.org/jpackage.asc'
  end
end

default['yum']['jpackage']['failovermethod'] = 'priority'
default['yum']['jpackage']['gpgcheck'] = false
default['yum']['jpackage']['enabled'] = true
default['yum']['jpackage']['managed'] = true
