require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe 'Atlassian Hipchat' do

  it 'has been installed' do
    expect(package('hipchat')).to be_installed
  end

  it 'has a symlink in \'/usr/bin\' pointing to the hipchat binary' do
    expect(file('/usr/bin/hipchat')).to be_linked_to '/opt/HipChat/bin/hipchat'
  end

  it 'has a .desktop launcher file' do
    expect(file('/usr/share/applications/hipchat.desktop')).to be_file
  end

end
