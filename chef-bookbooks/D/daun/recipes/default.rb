pkgconfig_package = value_for_platform_family(
  'rhel' => 'pkgconfig',
  'default' => 'pkg-config'
)
%W(cmake #{pkgconfig_package} gcc).each do |required_package|
  package_resource = package required_package do
    action :nothing
  end
  package_resource.run_action(:install)
end

openssl_package = value_for_platform_family(
  'suse' => 'libopenssl-devel',
  'debian' => 'libssl-dev',
  'default' => 'openssl-devel'
)
ssh_package = value_for_platform_family(
  'debian' => 'libssh2-1-dev',
  'default' => 'libssh2-devel'
)
[openssl_package, ssh_package].each do |optional_package|
  package_resource = package optional_package do
    action :nothing
  end
  package_resource.run_action(:install)
end

chef_gem 'daun' do
  compile_time true
  action :install
end

require 'daun'
