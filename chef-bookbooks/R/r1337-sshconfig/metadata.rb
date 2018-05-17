name 'r1337-sshconfig'
maintainer 'Matthew Ahrenstein'
maintainer_email 'matthew@route1337.com'
license 'MIT'
description 'Configure OpenSSH with standard or hardened settings'
long_description 'This Chef cookbook will configure SSH on Linux servers to be compliant with Route 1337 security policies. There are a few versions of the configuration depending on the recipe that is chosen'
version '0.1.5'
chef_version '>= 13.6.4' if respond_to?(:chef_version)
depends          'openssh'
issues_url 'https://github.com/route1337/chef-cookbook-sshconfig/issues'
source_url 'https://github.com/route1337/chef-cookbook-sshconfig'

%w{ ubuntu centos }.each do |os|
  supports os
end

recipe 'r1337-sshconfig::default', 'Call this recipe to run the correct configuration based on attribute settings'
recipe 'r1337-sshconfig::standardssh', 'This is a standard SSH config for environments that don\'t have stringent security requirements'
recipe 'r1337-sshconfig::hardenedssh', 'This recipe should be used in untrusted environments (DMZs) or in environments with tight security regulations'
