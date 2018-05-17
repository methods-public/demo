# $ knife supermarket share yum_utils "Operating Systems & Virtualization"
name             'yum_utils'
maintainer       'whitestar'
maintainer_email ''
license          'Apache 2.0'
description      'YUM Utilities'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
source_url       'http://scm.osdn.jp/gitroot/metasearch/grid-chef-repo.git'
issues_url       'https://osdn.jp/projects/metasearch/ticket'

%w( centos redhat fedora ).each do |os|
  supports os
end

depends          'platform_utils', '>= 0.4.0'
depends          'yum', '>= 3.0'
depends          'yum-epel'
