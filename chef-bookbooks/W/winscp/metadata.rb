name 'winscp'
maintainer 'Ellert van der Vecht'
maintainer_email 'evandervecht@schubergphilis.com'
license 'All rights reserved'
description 'Installs/Configures winscp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
recipe 'winscp::default', 'Installs WinSCP'
version '0.1.0'

supports 'windows'

depends 'windows'
