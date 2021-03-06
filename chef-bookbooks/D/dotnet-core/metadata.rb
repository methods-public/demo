name 'dotnet-core'
maintainer 'Jose M. Tobar'
maintainer_email 'ilovemysillybanana@gmail.com'
license 'Apache 2.0'
description 'Installs ASP.NET/.NET Core'
long_description 'Installs ASP.NET/.NET Core'
version '0.2.0'

source_url 'https://github.com/ilovemysillybanana/dotnet-cookbook'
issues_url 'https://github.com/ilovemysillybanana/dotnet-cookbook/issues'

depends 'yum', '~> 4.1.0'
depends 'apt', '~> 5.0.0'
depends 'sudo', '~> 3.1.0'
depends 'ohai', '~> 4.2.3'

supports 'ubuntu', '= 14.04'
supports 'ubuntu', '= 16.04'
supports 'ubuntu', '= 16.10'
supports 'debian', '~> 8.0.0'
supports 'fedora', '~> 23.0.0'
supports 'fedora', '~> 24.0.0'
supports 'centos', '>= 7.1'
supports 'oracle', '>= 7.1'
supports 'redhat', '>= 7.1'
