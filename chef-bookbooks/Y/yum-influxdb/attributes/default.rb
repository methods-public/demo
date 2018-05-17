platform_family = if node['platform_family'] == 'rhel'
                    'rhel'
                  else
                    'centos'
                  end

default['yum']['influxdb']['description'] = 'InfluxDB Repository - CentOS'
default['yum']['influxdb']['baseurl'] = "https://repos.influxdata.com/#{platform_family}/$releasever/$basearch/stable"
default['yum']['influxdb']['gpgkey'] = 'https://repos.influxdata.com/influxdb.key'
default['yum']['influxdb']['gpgcheck'] = true
default['yum']['influxdb']['enabled'] = true
default['yum']['influxdb']['managed'] = true
