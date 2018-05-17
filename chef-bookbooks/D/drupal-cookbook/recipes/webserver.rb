# Copyright 2015 Gabor Takacs

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Install Apache and configure its service.
include_recipe 'apache2::default'

# Enable access compatibility with Apache 2.2
link '/etc/httpd/mods-available/access_compat.load' do
  to '/etc/httpd/mods-enabled/access_compat.load'
  mode '0755'
  link_type :symbolic
end

# Create and enable our custom site.
web_app node['drupal-cookbook']['name'] do
  	template "#{node['drupal-cookbook']['config']}.erb"
end

# Create the document root.
directory node['apache']['docroot_dir'] do
  	recursive true
end

# Open port 80 & 443 to incoming traffic.
include_recipe 'iptables'
iptables_rule 'firewall'

# Install the mod_php5 Apache module.
include_recipe 'apache2::mod_php5'

# Install php-mysql.
package 'php-mysql' do
  	action :install
  	notifies :restart, 'service[apache2]'
end