name             'centos-preupg'
maintainer       'North County Tech Center, LLC'
maintainer_email 'kkeane@4nettech.com'
license          'GNU Public License 3.0'
description      'Installs/Configures centos-preupg'
long_description 'Installs and runs the Centos 6 to Centos 7 upgrade preparation tool'
version          '1.0.0'

# This cookbook only makes sense for CentOS
supports "centos"

depends "yum"

