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

name 'drupal-cookbook'
maintainer 'Gabor Takacs'
maintainer_email 'me@gabortakacs.com'
license 'Apache v2.0'
description 'Installs and configures Drupal 7 and Drush'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.6'
source_url 'https://github.com/ghaabor/drupal-cookbook'
issues_url 'https://github.com/ghaabor/drupal-cookbook/issues'
supports 'redhat'
supports 'centos'

depends 'auto-update', '~> 0.3.0'
depends 'apache2', '~> 3.1.0'
depends 'iptables', '~> 1.0.0'
depends 'selinux', '~> 0.9.0'
depends 'mysql2_chef_gem', '~> 1.0.0'
depends 'mysql', '~> 6.0.22'
depends 'database', '~> 4.0.6'
depends 'composer', '~> 2.0.0'
depends 'activelamp_composer', '~> 0.0.1'
depends 'activelamp_drupal', '~> 0.0.4'
