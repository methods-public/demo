#
# Cookbook Name::alphard-chef-deploy
# Attributes:: default
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

# Common Attributes

default['alphard']['deploy']['user'] = 'root'
default['alphard']['deploy']['group'] = 'root'
default['alphard']['deploy']['base'] = '/home/io.alphard'
default['alphard']['deploy']['current_directory'] = 'current'
default['alphard']['deploy']['script_template'] = 'script.sh.erb'
default['alphard']['deploy']['library_directory'] = 'lib'
default['alphard']['deploy']['configuration_directory'] = 'cnf'
default['alphard']['deploy']['binary_directory'] = 'bin'
default['alphard']['deploy']['executable_name'] = 'run.sh'
default['alphard']['deploy']['temporary_directory'] = 'tmp'
default['alphard']['deploy']['log_directory'] = 'log'
default['alphard']['deploy']['version_file'] = '.vrs'
default['alphard']['deploy']['snapshot_suffixes'] = %w(SNAPSHOT FEATURE RELEASE HOTFIX SUPPORT)

# Repository Attributes

default['alphard']['deploy']['repository']['type'] = 's3' # 'artifactory', 'local'
default['alphard']['deploy']['repository']['local']['path'] = '/ivy_local'
default['alphard']['deploy']['repository']['artifactory']['host'] = 'artifactory'
default['alphard']['deploy']['repository']['artifactory']['port'] = '80'
default['alphard']['deploy']['repository']['artifactory']['path'] = 'ivy-dependencies'
default['alphard']['deploy']['repository']['artifactory']['user'] = 'chef'
default['alphard']['deploy']['repository']['s3']['releases_bucket'] = 'repository.alphard.io/ivy/private/releases'
default['alphard']['deploy']['repository']['s3']['snapshots_bucket'] = 'repository.alphard.io/ivy/private/snapshots'

# Jvm Attributes

default['alphard']['deploy']['java_path'] = '/usr/bin/java'
