#
# Copyright (c) 2017 Make.org
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

# Install java package
package 'java-1.8.0-openjdk-headless' do
  retries 1
end

# Add logstash repository
yum_repository 'logstash' do
  baseurl 'https://artifacts.elastic.co/packages/5.x/yum'
  gpgcheck true
  gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  enabled true
  action :create
end

# Install logstash package
package 'logstash' do
  retries 1
end

# Configure logstash beats input and file output
logstash_conf = {}
logstash_conf['input_beats'] = <<HEREDOC
  input {
    beats {
      port => 5044
      ssl => true
      ssl_certificate => '/etc/ssl/certs/logstash.crt'
      ssl_key => '/etc/ssl/certs/logstash.key'
    }
  }
HEREDOC

logstash_conf['output_file'] = <<HEREDOC
  output {
    file {
      path => '/var/lib/logstash/test'
    }
  }
HEREDOC

logstash_conf.each do |conf, content|
  file "/etc/logstash/conf.d/#{conf}.conf" do
    content content
    mode '0755'
    owner 'root'
    group 'root'
  end
end

# Configure logstash ssl certificates
%w[logstash.crt logstash.key].each do |ssl_file|
  cookbook_file "/etc/ssl/certs/#{ssl_file}" do
    source ssl_file
    mode '0755'
    owner 'root'
    group 'root'
  end
end

# Execute system-install binary to install systemd unit
execute 'logstash_service' do
  command '/usr/share/logstash/bin/system-install'
  creates '/etc/systemd/system/logstash.service'
end

# Start logstash service
service 'logstash' do
  action %i[enable start]
end

# Send log test to systemd
execute 'send_log' do
  command '/bin/systemd-cat -t test /bin/echo This is a test log'
end
