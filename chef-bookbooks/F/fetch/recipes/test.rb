#
# Cookbook Name:: fetch
# Recipe:: test
#
# Copyright 2016, Jean-Francois Theroux
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

# service to use to test notifications
service 'rsyslog'

# gzip - download to default location and extract
fetch 'https://github.com/jenkinsci/mailer-plugin/archive/mailer-1.17.tar.gz' do
  extract_to '/tmp/mailer-plugin-1.17'
  notifies :restart, 'service[rsyslog]', :immediately
end

# gzip - download to custom location and extract to custom location
fetch 'https://github.com/jenkinsci/mailer-plugin/archive/mailer-1.16.tar.gz' do
  download_to '/tmp'
  extract_to '/tmp/mailer-plugin-1.16'
end

# gzip - download to default location, extract and symlink
fetch 'https://github.com/jenkinsci/mailer-plugin/archive/mailer-1.15.tar.gz' do
  extract_to '/tmp/mailer-plugin-1.15'
  symlink true
  symlink_to '/tmp/mailer-plugin'
end

# gzip - download to default location, extract and don't strip first directory
fetch 'https://github.com/jenkinsci/mailer-plugin/archive/mailer-1.14.tar.gz' do
  extract_to '/tmp/mailer-plugin-1.14'
  strip false
end
