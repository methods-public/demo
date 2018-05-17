#
# Cookbook Name:: berkshelf-api-server
# Attributes:: default
#
# Copyright 2015-2017, whitestar
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

# added attributes
default[:berkshelf_api][:chef_gem][:clear_sources] = false
default[:berkshelf_api][:chef_gem][:source] = nil
default[:berkshelf_api][:chef_gem][:options] = nil
default[:berkshelf_api][:"chef-vault"][:version] = '~> 2.6'
default[:berkshelf_api][:app_host] = '0.0.0.0'
default[:berkshelf_api][:proxy][:ssl] = false
default[:berkshelf_api][:proxy][:ssl_certificate] = ''
default[:berkshelf_api][:proxy][:ssl_certificate_key] = ''
=begin
default[:berkshelf_api][:proxy][:ssl_certificate_key_vault_item] = {
  # Examples
  :vault => 'ssl_server_keys',
  :name => '<COMMON_NAME>',
  # single key or nested hash key path delimited by slash
  # Case 1.
  :env_context => false,
  :key => 'private'
  # -> item['private']
  # Case 2.
  #:env_context => true,
  #:key => 'private'
  # -> item[node.chef_environment]['private']
  # Case 3.
  #:env_context => true,
  #:key => nil,  # or '' or undefined
  # -> item[node.chef_environment]
  # Case 4.
  #:env_context => true,
  #:key => 'hash/path/to/private/key'
  # -> item[node.chef_environment]['hash']['path']['to']['private']['key']
}
=end

default[:berkshelf_api][:config][:endpoints] = [
=begin
  # Examples
  {
    :options => {
      :client_key => '/etc/berkshelf/api-server/<ORG_NAME>-berkshelf.pem',
      # added attributes
      :client_key_vault_item => {
        :vault => 'berks_api_client_keys',
        :name => '<ORG_NAME>',
        # single key or nested hash key path delimited by slash
        :env_context => false,
        :key => 'berkshelf'
        #:env_context => true,
        #:key => 'hash/path/to/private/key'
      }
    }
  },
=end
]

force_default[:nginx][:version] = '1.10.2'
force_default[:nginx][:source][:checksum] = '1045ac4987a396e2fa5d0011daf8987b612dd2f05181b67507da68cbe7d765c2'
#force_default[:nginx][:version] = '1.8.1'
#force_default[:nginx][:source][:checksum] = '8f4b3c630966c044ec72715754334d1fdf741caa1d5795fb4646c27d09f797b7'
#force_default[:nginx][:version] = '1.6.3'
#force_default[:nginx][:source][:checksum] = '0a98e95b366e4d6042f331e1fa4d70e18fd1e49d8993e589008e70e742b7e757'
#force_default[:nginx][:version] = '1.2.9'
#force_default[:nginx][:source][:checksum] = '71486674b757f6aa93a4f7ec6e68ef82557d4944deeb08f3ad3de00079d22b1c'

node.from_file(run_context.resolve_attribute('berkshelf-api-server', 'default'))
# https://github.com/miketheman/nginx/blob/v2.7.6/attributes/source.rb
node.from_file(run_context.resolve_attribute('nginx', 'source'))
