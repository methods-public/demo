case node['platform_family']
when 'rhel', 'fedora'
  yum_repository 'tideways' do
    description 'Tideways'
    url node['tideways']['yum_url']
    if respond_to?(:key)
      key node['tideways']['gpgkey']
    else
      gpgkey node['tideways']['gpgkey']
    end
    action :add
  end

when 'debian'
  apt_repository 'tideways' do
    uri node['tideways']['apt_url']
    distribution 'debian'
    components ['main']
    key node['tideways']['gpgkey']
    action :add
  end
end
