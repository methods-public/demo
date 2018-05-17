[
  :centos,
  :redhat,
  :scientific
].each do |rh_distro|
  Chef::Platform.set platform: rh_distro, version: '>= 7.0', resource: :couch_service, provider: Chef::Provider::CouchService::Systemd
  Chef::Platform.set platform: rh_distro, version: '< 7.0', resource: :couch_service, provider: Chef::Provider::CouchService::Sysvinit
end
Chef::Platform.set platform: :ubuntu, resource: :couch_service, provider: Chef::Provider::CouchService::Upstart
