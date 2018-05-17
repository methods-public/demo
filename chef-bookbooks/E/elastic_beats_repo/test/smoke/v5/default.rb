# # encoding: utf-8

# Inspec test for recipe elastic_beats_repo::v1

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

describe package('filebeat') do
  it { should be_installed }
  its('version') { should match '5.6.9' }
end

describe package('packetbeat') do
  it { should be_installed }
  its('version') { should match '5.6.9' }
end

describe package('metricbeat') do
  it { should be_installed }
  its('version') { should match '5.6.9' }
end
