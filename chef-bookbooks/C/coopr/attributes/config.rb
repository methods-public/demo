#
# Cookbook Name:: coopr
# Attribute:: config
#
# Copyright © 2013-2015 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Default: conf.chef
default['coopr']['conf_dir'] = 'conf.chef'

# User/Group
default['coopr']['user'] = 'coopr'
default['coopr']['group'] = 'coopr'

# coopr-site.xml
default['coopr']['coopr_site']['server.host'] = '127.0.0.1'

# Set the following property to use an external ZooKeeper quorum:
# default['coopr']['coopr_site']['server.zookeeper.quorum'] = 'localhost:2181'

# Set the following attribtues to use an external MySQL (or PostgreSQL, see docs for supported RDBMS)
# default['coopr']['coopr_site']['server.jdbc.driver'] = 'com.mysql.jdbc.Driver'
# default['coopr']['coopr_site']['server.jdbc.connection.string'] = 'jdbc:mysql://127.0.0.1:3306/coopr?useLegacyDatetimeCode=false'
# default['coopr']['coopr_site']['server.db.user'] = 'coopr'
# default['coopr']['coopr_site']['server.db.password'] = 'someinsecurepassword'
# default['coopr']['coopr_site']['server.jdbc.validation.query'] = 'SELECT 1'

# provisioner-site.xml
default['coopr']['provisioner_site']['provisioner.server.uri'] = 'http://127.0.0.1:55055'
default['coopr']['provisioner_site']['provisioner.register.ip'] = '127.0.0.1'
default['coopr']['provisioner_site']['provisioner.log.level'] = 'info'
