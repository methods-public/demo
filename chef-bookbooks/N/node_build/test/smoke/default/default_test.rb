# # encoding: utf-8

# Inspec test for recipe node_build::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command('/usr/local/bin/node-build') do
  it { should exist }
  its('exit_status') { should eq 1 }
end

describe command('/home/user-with-node-build/plugins/node-build/bin/node-build') do
  it { should exist }
  its('exit_status') { should eq 1 }
end
