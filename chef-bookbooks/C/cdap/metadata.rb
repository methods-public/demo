name             'cdap'
maintainer       'Cask Data, Inc.'
maintainer_email 'ops@cask.co'
license          'Apache-2.0'
description      'Installs/Configures Cask Data Application Platform (CDAP)'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.4.0'

%w(ambari ark apt java nodejs ntp yum).each do |cb|
  depends cb
end

depends 'hadoop', '>= 2.0.0'
depends 'krb5', '>= 2.2.1'

%w(amazon centos debian redhat scientific ubuntu).each do |os|
  supports os
end

source_url 'https://github.com/caskdata/cdap_cookbook' if respond_to?(:source_url)
issues_url 'https://issues.cask.co/browse/COOK/component/10603' if respond_to?(:issues_url)
chef_version '>= 11' if respond_to?(:chef_version)
