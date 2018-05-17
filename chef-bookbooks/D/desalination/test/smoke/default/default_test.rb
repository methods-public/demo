# encoding: utf-8
# author: Jon Middleton

control '01' do
  impact 1.0
  title 'Verify salt-minion service'
  desc 'Ensures salt-minion service is not running'

  describe service('salt-minion') do
    it { should_not be_enabled }
    it { should_not be_installed }
    it { should_not be_running }
  end
end

control '02' do
  impact 1.0
  title 'Verify salt-minion Package'
  desc 'Ensures salt-minion package is not installed'

  describe package('salt-minion') do
    it { should_not be_installed }
  end

  if os.family == 'redhat'
    describe package('salt') do
      it { should_not be_installed }
    end
  elsif os.family == 'debian'
    describe package('salt-common') do
      it { should_not be_installed }
    end
  end
end

control '03' do
  impact 0.5
  title 'Verify salt config'
  desc 'Ensures salt is not configured'

  describe directory('/etc/salt/') do
    it { should_not exist }
  end
end

control '04' do
  impact 0.5
  title 'Verify salt repos are missing'
  desc 'Ensures Salt cannot be installed via package tools'

  if os.family == 'redhat'
    describe package('salt-repo') do
      it { should_not be_installed }
    end
  elsif os.family == 'debian'
    describe file('/etc/apt/sources.list.d/saltstack.list') do
      it { should_not exist }
    end
  end
end
