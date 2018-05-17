name 'firefox-custom'
maintainer 'digitalr00ts'
maintainer_email 'development@digitalr00ts.org'
license 'Apache 2.0'
description 'Customizes Firefox'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.1'

%w(redhat centos scientific windows mac_os_x ubuntu).each do |os|
  supports os
end

suggests 'dmg'
suggests 'windows', '~> 1.38.2'
# depends 'windows'

depends 'firefox', '~> 2.0.5'

source_url 'https://github.com/digitalr00ts/firefox-custom' if respond_to?(:source_url)
issues_url 'https://github.com/digitalr00ts/firefox-custom/issues' if respond_to?(:issues_url)
