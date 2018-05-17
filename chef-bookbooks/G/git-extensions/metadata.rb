name 'git-extensions'
maintainer 'Ellert van der Vecht'
maintainer_email 'evandervecht@schubergphilis.com'
license 'All rights reserved'
description 'Installs/Configures git-extensions'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
recipe 'git-extensions::default', 'Installs Git Extensions'
version '0.1.1'

supports 'windows'

depends 'windows'

source_url 'https://github.com/ridiculousness/cookbook.gitextensions'
issues_url 'https://github.com/ridiculousness/cookbook.gitextensions/issues'
