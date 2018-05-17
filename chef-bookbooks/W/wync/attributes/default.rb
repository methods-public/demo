case node['platform']
when 'debian'
  default['wync']['pkg'] = 'wync_debian64_v2.0.257.deb'
  default['wync']['download_url'] = 'http://fisil.com/linux/wync_debian64_v2.0.257.deb'
  default['wync']['provider'] = 'dpkg_package'
when 'ubuntu'
  default['wync']['pkg'] = 'wync_ubuntu64_v2.0.302.deb'
  default['wync']['download_url'] = 'http://fisil.com/linux/wync_ubuntu64_v2.0.294.deb'
  default['wync']['provider'] = 'dpkg_package'
when 'suse'
  default['wync']['pkg'] = 'wync_suse64_v2.0.301.rpm'
  default['wync']['download_url'] = 'http://fisil.com/linux/wync_suse64_v2.0.294.rpm'
  default['wync']['provider'] = 'yum_package'
else
  default['wync']['pkg'] = 'wync_redhat64_v2.0.302.rpm'
  default['wync']['download_url'] = 'http://fisil.com/linux/wync_redhat64_v2.0.294.rpm'
  default['wync']['provider'] = 'yum_package'
end
