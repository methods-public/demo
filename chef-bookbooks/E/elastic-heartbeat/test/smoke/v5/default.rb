# # encoding: utf-8

# Inspec test for cookbook elastic-heartbeat

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if %w[redhat fedora amazon].include?(os[:family])
  describe file('/etc/yum.repos.d/beats.repo') do
    its('content') { should match %r{https://artifacts.elastic.co/packages/5.x/yum} }
  end
else
  describe file('/etc/apt/sources.list.d/beats.list') do
    its('content') { should match %r{https://artifacts.elastic.co/packages/5.x/apt} }
  end
end

describe package('heartbeat') do
  it { should be_installed }
  its('version') { should match '5.2.2' }
end

describe service('heartbeat') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
