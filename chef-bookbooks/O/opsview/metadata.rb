name             'opsview'
maintainer       'Biola University'
maintainer_email 'jared.king@biola.edu'
license          'Apache 2.0'
description      'Installs and configures Opsview'
version          '3.0.2'

depends          'apt', '>= 2.0'
depends          'ark', '~> 0.9.0'
depends          'chef-vault', '>= 1.0'
depends          'mysql', '< 6.0'
depends          'openssl', '>= 2.0'
depends          'oracle_instant_client', '>= 0.2.0'
depends          'vsphere_perl_sdk', '>= 1.0'
depends          'yum', '>= 3.0'
depends          'yum-epel', '~> 0.6.0'

%w(ubuntu redhat centos windows).each do |os|
  supports os
end
