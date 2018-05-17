# # encoding: utf-8

describe package('chronograf') do
  it { should be_installed }
end

describe service('chronograf') do
  it { should be_enabled }
  it { should be_running }
end
