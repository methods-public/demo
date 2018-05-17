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

include_attribute 'drupal-cookbook::install'

# auto-update attributes
#default['auto-update']['enabled'] = 'true'

# Linux system user and group for the server
default['drupal-cookbook']['user'] = 'web_admin'
default['drupal-cookbook']['group'] = 'web_admin'

# Apache configuration file
default['drupal-cookbook']['name'] = 'drupal'
default['drupal-cookbook']['config'] = 'drupal.conf'

# iptables auto install rules disabled
default['iptables']['install_rules'] = false

# shared db data
default['drupal-cookbook']['db']['host'] = '127.0.0.1'
default['drupal-cookbook']['db']['dbname']  = 'drupal'

# php-devel removed because of crashing
default['php']['packages'] = %w{ php php-cli php-pear php-gd php-pdo }

# apache docroot redefine
default['apache']['docroot_dir'] = '/var/www/drupal'
