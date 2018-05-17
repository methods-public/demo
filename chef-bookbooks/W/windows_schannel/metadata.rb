name 'windows_schannel'
maintainer 'digitalgaz'
maintainer_email 'digitalgaz@hotmail.com'
license 'Apache-2.0'
description 'Configures windows schannel security support provider (SSP). Use it to disable support for the protocols like SSL and the RC4 Cipher. One step towards meeting CIS PCI FIPS compliance.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

source_url 'https://github.com/digitalGaz/windows_schannel' if respond_to?(:source_url)
issues_url 'https://github.com/digitalGaz/windows_schannel/issues' if respond_to?(:issues_url)

supports 'windows'

chef_version '>= 12.5' if respond_to?(:chef_version)
