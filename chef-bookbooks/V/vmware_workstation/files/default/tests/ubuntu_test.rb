require File.expand_path('helpers', File.dirname(__FILE__))
require 'minitest/spec'

describe 'vmware_workstation::ubuntu' do

  include Helpers::MinitestHandler

  it 'has downloaded vmware workstation' do
    assert File.exists?('/var/chef/cache/VMware-Workstation-Full-10.0.2-1744117.x86_64.bundle')
  end

  it 'sets the necessary permissions' do
    file('/var/chef/cache/VMware-Workstation-Full-10.0.2-1744117.x86_64.bundle').\
      must_have(:mode, '00644')
  end

  it 'has installed vmware workstation' do
    s = service('vmware')
    s.supports([:status])
    s.run_context = run_context
    ::Chef::Platform.provider_for_resource(s).load_current_resource.must_be_running
  end

end
