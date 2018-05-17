# Inspec test for recipe chrony_ii::package

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('ntp') do
  it { should_not be_installed }
end

describe package('ntpdate') do
  it { should_not be_installed }
end

describe package('chrony') do
  it { should be_installed }
end
