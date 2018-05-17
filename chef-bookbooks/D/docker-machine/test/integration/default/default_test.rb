 # encoding: utf-8

# Inspec test for recipe docker-machine::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe group('docker') do
  it { should exist }
end

describe package('curl') do
  it { should be_installed }
end

describe file('/usr/local/bin/docker-machine') do
  it { should be_file }
  it { should be_owned_by('root') }
  it { should be_grouped_into('docker') }
  its('mode') { should cmp '0750' }
end
