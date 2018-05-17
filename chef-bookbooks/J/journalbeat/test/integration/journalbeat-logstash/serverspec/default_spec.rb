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

require 'spec_helper'

describe service('logstash') do
  it { should be_running.under('systemd') }
end

describe port(5044) do
  it { should be_listening }
end

describe service('journalbeat') do
  it { should be_enabled }
  it { should be_running.under('systemd') }
end

describe file('/opt/journalbeat-v5.4.1/journalbeat.yml') do
  it { should contain('hosts: localhost:5044') }
  it { should contain('path.home: "/opt/journalbeat-v5.4.1"') }
  it { should contain('path.config: "/opt/journalbeat-v5.4.1"') }
  it { should contain('path.data: "/opt/journalbeat-v5.4.1/data"') }
  it { should contain('path.logs: "/opt/journalbeat-v5.4.1/logs"') }
  it { should contain('logging.level: warning') }
end

(1..20).each do |try|
  msg = 'This is a test log'
  cmd = "grep '#{msg}' /var/lib/logstash/test"
  result = `#{cmd} 2>&1`
  break if result.include?(msg)
  puts "Waiting for test log message sent in logstash … \
        Try ##{try}/20, waiting 5s"
  sleep(5)
end

describe file('/var/lib/logstash/test') do
  it { should contain('"MESSAGE":"This is a test log"') }
  it { should contain('"SYSLOG_IDENTIFIER":"test"') }
end
