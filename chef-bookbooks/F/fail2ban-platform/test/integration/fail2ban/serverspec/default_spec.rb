#
# Copyright (c) 2018 Make.org
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

default_config = <<-DEFAULT_CONFIG.gsub(/^ */, '')
  [DEFAULT]
  ignoreip =
  bantime = 1200
  maxRetry = 1
DEFAULT_CONFIG

sshd_config = <<-SSHD_CONFIG.gsub(/^ */, '')
  [sshd]
  enabled = true
SSHD_CONFIG

describe file('/etc/fail2ban/jail.d/default.conf') do
  it { should contain(default_config) }
end

describe file('/etc/fail2ban/jail.d/sshd.conf') do
  it { should contain(sshd_config) }
end

describe service('fail2ban') do
  it { should be_enabled }
  it { should be_running.under('systemd') }
end

describe file('/var/log/fail2ban.log') do
  it { should contain("Creating new jail 'sshd'") }
  it { should contain('INFO    Set banTime = 1200') }
  it { should contain('INFO    Set maxRetry = 1') }
  it { should contain('NOTICE  [sshd] Ban 127.0.0.1') }
end

describe iptables do
  input_rule = '-p tcp -m multiport --dports 22 -j f2b-sshd'
  it { should have_rule(input_rule).with_table('filter').with_chain('INPUT') }
  f2b_rule = '-s 127.0.0.1/32 -j REJECT --reject-with icmp-port-unreachable'
  it { should have_rule(f2b_rule).with_table('filter').with_chain('f2b-sshd') }
end
