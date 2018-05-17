name 'crenv'
maintainer 'Jose M. Tobar'
maintainer_email 'ilovemysillybanana@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures crenv'
long_description 'Installs/Configures crenv'
version '1.0.1'

depends 'yum',   '~> 4.0.0'
depends 'yum-epel', '~> 1.0.0'
depends 'selinux', '~> 0.9.0'
depends 'sudo', '~> 3.0.0'
depends 'git', '~> 5.0.0'
depends 'build-essential', '~> 7.0.3'

supports 'ubuntu', '= 14.04'
supports 'ubuntu', '= 16.04'
supports 'ubuntu', '= 16.10'
supports 'debian', '~> 8.0.0'
supports 'fedora', '~> 23.0.0'
supports 'fedora', '~> 24.0.0'
supports 'centos', '>= 7.1'
supports 'oracle', '>= 7.1'
supports 'redhat', '>= 7.1'


source_url 'https://github.com/ilovemysillybanana/crenv-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/ilovemysillybanana/crenv-cookbook/issues' if respond_to?(:issues_url)
