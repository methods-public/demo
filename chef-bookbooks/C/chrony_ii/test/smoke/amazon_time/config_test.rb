# Inspec test for recipe chrony_ii::config

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

config_path = '/etc/chrony.conf'

describe file(config_path) do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should eq 0o644 }
  its('content') { should match(/^# Chef managed/) }
  its('content') { should match(/^server 169\.254\.169\.123 prefer iburst$/) }
end
