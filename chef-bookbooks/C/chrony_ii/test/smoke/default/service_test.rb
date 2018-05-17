# Inspec test for recipe chrony_ii::service

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

service_name = case os[:family]
               when 'redhat', 'amazon'
                 'chronyd'
               when 'debian'
                 'chrony'
               end

describe service(service_name) do
  it { should be_enabled }
  it { should be_running }
end
