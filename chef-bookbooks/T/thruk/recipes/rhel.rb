# for mod_fcgid
include_recipe 'yum-epel'

package 'perl-Data-Dumper' if node['platform_version'].to_f >= 7.0

if node['thruk']['version'].split('.')[0].to_i < 2
  remote_file "#{Chef::Config[:file_cache_path]}/#{node['thruk']['pkg_name']}" do
    action :create_if_missing
    source "#{node['thruk']['pkg_url']}/#{node['thruk']['pkg_name']}"
    mode '0644'
    backup false
    not_if "rpm -qa | grep -q '^thruk-#{node['thruk']['version']}'"
    notifies :install, 'yum_package[thruk]', :immediately
  end

  yum_package 'thruk' do
    source "#{Chef::Config[:file_cache_path]}/#{node['thruk']['pkg_name']}"
    action :nothing
  end

  file 'thruk-cleanup' do
    path "#{Chef::Config[:file_cache_path]}/#{node['thruk']['pkg_name']}"
    action :delete
  end
else
  include_recipe 'yum'

  yum_repository 'labs_consol_stable' do
    baseurl "http://labs.consol.de/repo/stable/rhel#{node['thruk']['major']}/$basearch"
    gpgcheck false
    gpgkey 'http://labs.consol.de/repo/stable/RPM-GPG-KEY'
    enabled true
    action :create
  end

  package 'thruk' do
    version node['thruk']['version']
  end

end
