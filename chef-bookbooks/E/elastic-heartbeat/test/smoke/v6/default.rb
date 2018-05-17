# # encoding: utf-8

# Inspec test for cookbook elastic-heartbeat

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if %w[redhat fedora amazon].include?(os[:family])
  describe file('/etc/yum.repos.d/beats.repo') do
    its('content') { should match %r{https://artifacts.elastic.co/packages/6.x/yum} }
  end
else
  describe file('/etc/apt/sources.list.d/beats.list') do
    its('content') { should match %r{https://artifacts.elastic.co/packages/6.x/apt} }
  end
end

describe package('heartbeat-elastic') do
  it { should be_installed }
  its('version') { should match '6.2.3' }
end

describe service('heartbeat-elastic') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
