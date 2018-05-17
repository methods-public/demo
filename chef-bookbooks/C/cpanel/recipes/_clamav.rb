# install clamav using cpanel style

execute 'install_cp_clamav' do
  command '/scripts/check_cpanel_rpms --fix --targets=clamav'
  action :nothing
end

execute 'clamav_unofficial_fresh' do
  command '/usr/bin/clamav-unofficial-sigs.sh'
  action :nothing
end
 
execute 'enable_cp_clamav' do
  command '/scripts/update_local_rpm_versions --edit target_settings.clamav installed'
  not_if { node[:packages].include?('cpanel-clamav') }
  notifies :run, 'execute[install_cp_clamav]', :immediately
end

package 'clamav-unofficial-sigs'

cookbook_file '/etc/clamav-unofficial-sigs/clamav-unofficial-sigs.conf' do
  source 'clamav-unofficial-sigs.conf'
  notifies :run, 'execute[clamav_unofficial_fresh]', :immediately
end

systemd_unit 'clamd' do
  action [ :start ]
end
