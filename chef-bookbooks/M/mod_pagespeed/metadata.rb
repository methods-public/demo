name             'mod_pagespeed'
maintainer       'Taylor Price'
maintainer_email 'tayworm@gmail.com'
issues_url 'https://github.com/drpebcak/mod_pagespeed_cookbook/issues'
source_url 'https://github.com/drpebcak/mod_pagespeed_cookbook'
license          'Apache 2.0'
description      'Installs/Configures mod_pagespeed for use with apache'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'

depends 'apache2'

supports 'debian'
supports 'ubuntu'
supports 'redhat'
supports 'centos'
supports 'amazon'
supports 'fedora'
