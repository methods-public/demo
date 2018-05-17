#
# Copyright 2014, Kevin Gilpin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Alternatively, package 'ruby-devel'
case node.platform_family
when 'rhel'
  package 'rubygem-json'
else
  package 'ruby-json'
end

chef_gem 'conjur-cli'
chef_gem 'conjur-asset-host-factory'

appliance_url = node.conjur.configuration.appliance_url
account = node.conjur.configuration.account
netrc_path = node.conjur.configuration.netrc_path
cert_file = "/etc/conjur-#{account}.pem"

ConjurHelper.update_config(node) do |conjur_config|
  conjur_config['appliance_url'] = appliance_url
  conjur_config['account'] = account
  conjur_config['netrc_path'] = netrc_path
end

if File.exist?(cert_file)
  File.chmod 0644, cert_file
  ConjurHelper.update_config(node) do |conjur_config|
    conjur_config['cert_file'] = cert_file
  end
end

# Store the Conjur SSL certificate coming in a string
if node.conjur.configuration['ssl_certificate']
  require 'fileutils'
  File.write(cert_file, node.conjur.configuration.ssl_certificate)
  File.chmod 0644, cert_file
  ConjurHelper.update_config(node) do |conjur_config|
    conjur_config['cert_file'] = cert_file
  end
end

# Configure the Conjur client using the config we've just written.
ConjurHelper.configure! node

# Create the host identity if it doesn't exist.
unless ConjurHelper.credentials?
  require 'uri'
  require 'conjur-asset-host-factory'

  Chef::Log.debug "Conjur host identity not found in #{ConjurHelper.netrc_file}"
  
  token   = node.conjur.host_factory_token
  host_id = node.conjur.host_identity.id

  Chef::Log.info "Creating Conjur host identity '#{host_id}'"

  host = Conjur::API.host_factory_create_host token, host_id
  
  ConjurHelper.save_credentials [ "host/#{host['id']}", host['api_key'] ]
else
  Chef::Log.debug "Conjur host identity already exists in #{ConjurHelper.netrc_file}"
end
