name 'gnugpg'
maintainer 'Rodel Manalo Talampas'
maintainer_email 'rodel.talampas@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures gnugpg'
long_description 'Installs/Configures gnugpg'
version '0.1.1'
chef_version '>= 12.5' if respond_to?(:chef_version)

supports 'centos', '>= 6.2'
supports 'amazon', '>= 2016.09'
supports 'windows'

depends 'ohai', '>= 4.0.0'

source_url 'https://github.com/rodel-talampas/gnugpg' if respond_to?(:source_url)
issues_url 'https://github.com/rodel-talampas/gnugpg/issues' if respond_to?(:issues_url)
