name              'conjur-host-identity'
maintainer        'Conjur, Inc.'
maintainer_email  'kgilpin@conjur.net'
license           'MIT'
description       'Obtains and installs the Conjur host identity from Chef attributes'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.2'

attribute "conjur/host_factory_token", 
  description: "Conjur host factory token used to create the host identity.",
  required: "required"
attribute "conjur/host_identity/id",
  description: "Identity which will be assigned to the new host.",
  required: "required"
attribute "conjur/configuration/appliance_url",
  description: "URL of the Conjur service, for example https://conjur/api.",
  required: "required"
attribute "conjur/configuration/account",
  description: "Conjur organization account name",
  required: "required"
attribute "conjur/configuration/ssl_certificate",
  description: %Q{SSL certificate of the Conjur service. Substitute line breaks with the \n newline character.},
  required: "required"
attribute "conjur/configuration_file",
  description: "Alternate location for the Conjur configuration file. Default is /etc/conjur.conf"
attribute "conjur/configuration/netrc_path",
  description: "Alternate location for the Conjur login cache. Default is /etc/conjur.identity"

%w(debian ubuntu centos fedora).each do |platform|
  supports platform
end
