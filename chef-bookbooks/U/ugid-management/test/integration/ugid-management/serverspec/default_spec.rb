#
# Copyright (c) 2016 Sam4Mobile, 2017-2018 Make.org
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

# rubocop:disable Metrics/BlockLength
require 'spec_helper'

describe 'Resource user' do
  it 'user_a should be created with ugid 202 and shell /sbin/nologin' do
    expect(file('/etc/passwd'))
      .to contain('user_a:x:202:202::/home/user_a:/sbin/nologin')
  end

  it 'user_b should be created with ugid 203 and shell /bin/bash' do
    expect(file('/etc/passwd'))
      .to contain('user_b:x:203:203::/home/user_b:/bin/bash')
  end
end

describe 'RPM users' do
  it 'chrony should be ugid 204, /var/lib/chrony and /sbin/nologin' do
    expect(file('/etc/passwd'))
      .to contain('chrony:x:204:204::/var/lib/chrony:/sbin/nologin')
  end

  it 'dovenull should be 205, /usr/libexec/dovecot & /sbin/nologin-test' do
    expect(file('/etc/passwd')).to contain(
      'dovenull:x:205:205::/usr/libexec/dovecot:/sbin/nologin-test'
    )
  end

  it 'dovecot and named should be created by the rpm' do
    expect(file('/etc/passwd')).to contain(
      'dovecot:x:97:97:Dovecot IMAP server'\
      ":/usr/libexec/dovecot:/sbin/nologin\n"\
      'named:x:25:25:Named:/var/named:/sbin/nologin'
    )
  end

  it 'docker user should NOT be created' do
    expect(file('/etc/passwd')).to_not contain('docker:x')
  end

  it 'docker group should be created' do
    expect(file('/etc/group')).to contain('docker:x:2420:')
  end
end
describe 'RPM without users' do
  it 'Package which should be installed' do
    expect(package('which')).to be_installed
  end
end

describe 'create recipe' do
  it 'superadmin must be created' do
    expect(file('/etc/passwd')).to contain(
      'superadmin:x:2000:100:Super Admin:/home/superadmin:/bin/sh'
    )
  end

  it 'auser must be created' do
    expect(file('/etc/passwd')).to contain(
      'auser:x:2001:100:A user:/home/auser:/bin/sh'
    )
  end
end

describe 'Users/groups not created by chef and checked by check recipe' do
  it 'foobarbefore should be created and ok' do
    expect(file('/etc/passwd'))
      .to contain('foobarbefore:x:1000:100::/home/foobarbefore:/bin/bash')
  end

  it 'foobarafter should be created and ok' do
    expect(file('/etc/passwd'))
      .to contain('foobarafter:x:1002:100::/home/foobarafter:/bin/bash')
  end

  it 'errorbefore should be created' do
    expect(file('/etc/passwd'))
      .to contain('errorbefore:x:1001:1001::/home/errorbefore:/bin/bash')
  end

  it 'errorafter should be created' do
    expect(file('/etc/passwd'))
      .to contain('errorafter:x:1003:1003::/home/errorafter:/bin/bash')
  end

  it 'team should be created' do
    expect(file('/etc/group'))
      .to contain('team:x:2400:')
  end

  it 'failgroup should be created' do
    expect(file('/etc/group'))
      .to contain('failgroup:x:2500:')
  end

  it 'devops should be created' do
    expect(file('/etc/group'))
      .to contain('devops:x:2410:')
  end

  it 'anotherfail group should be created' do
    expect(file('/etc/group'))
      .to contain('anotherfail:x:2510:')
  end

  error = '[UGId control] These users/groups are invalid:'
  in_error = 'errorbefore, failgroup, errorafter, anotherfail'
  it "#{in_error} users and groups should trigger an error" do
    msg = "#{error} #{in_error}"
    expect(file('/tmp/check_errors')).to contain(msg)
  end
end
# rubocop:enable Metrics/BlockLength
