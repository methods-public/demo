name             'mecab-python'
maintainer       'kogecoo'
maintainer_email 'kogecoo@gmail.com'
license          'Apache 2.0'
description      'Installs an official python binding for mecab' 
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends 'mecab'

supports 'centos'
supports 'debian'
supports 'ubuntu'
