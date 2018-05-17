name 'r1337-certmanage'
maintainer 'Matthew Ahrenstein'
maintainer_email 'matthew@route1337.com'
license 'MIT'
description 'Manages SSL certificates and keys via Chef Vault'
long_description 'This Chef cookbook will manage SSL certificates and keys through the use of Chef Vault.'
version '0.1.2'
chef_version '>= 13.6.4' if respond_to?(:chef_version)
issues_url 'https://github.com/route1337/chef-cookbook-certmanage/issues'
source_url 'https://github.com/route1337/chef-cookbook-certmanage'
depends 'chef-vault'
depends 'managed_directory'

%w{ ubuntu centos }.each do |os|
  supports os
end

recipe 'r1337-certmanage::default', 'Call this recipe to load Chef Vault and run the certificate and key management recipes'
recipe 'r1337-certmanage::prereqs', 'Configure the base requirements for Route 1337 style SSL certificate management'
recipe 'r1337-certmanage::certdeploy', 'Deploy the SSL certificates and their corresponding keys from Chef Vault'
recipe 'r1337-certmanage::maintenance', 'Perform cleanup of removed certs and keys as well as unmanaged files in the /data/ssl directory'