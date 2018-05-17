name             'shadowsocks_ng'
maintainer       'Alexander Merkulov'
maintainer_email 'sasha@merqlove.ru'
license          'MIT'
description      'Installs/Configures shadowsocks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.5'

depends 'poise-service', '~> 1.5.1'
depends 'poise-python'
depends 'build-essential'

supports 'ubuntu'
supports 'debian'
supports 'centos'

source_url 'https://github.com/merqlove-cookbooks/chef-shadowsocks_ng'
issues_url 'https://github.com/merqlove-cookbooks/chef-shadowsocks_ng/issues'
