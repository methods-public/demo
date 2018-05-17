name             'no-ip'
maintainer       'Christoffer Reijer'
maintainer_email 'ephracis at gmail'
license          'GPL v3'
description      'Installs the No-IP agent on the node'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'
chef_version     '~> 12'
issues_url       'http://github.com/simplare-cookbooks/no-ip/issues'
source_url       'http://github.com/simplare-cookbooks/no-ip'
depends          'yum-epel'
depends          'tarball'
depends          'chef-vault'
attribute        'noip/username',
                 display_name: 'Username at noip.com',
                 description: 'The username to use at noip.com',
                 type: 'string',
                 require: 'required'
supports         'ubuntu', '= 14.04'
supports         'centos', '= 7.2'
