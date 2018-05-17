
default['spacewalk']['server']['db']['type'] = 'postgres'
default['spacewalk']['server']['errata'] = true
default['spacewalk']['hostname'] = node['hostname']

# Answer file configuration
default['spacewalk']['server']['admin_email'] = 'root@localhost'
default['spacewalk']['server']['ssl']['cnames'] = 'spacewalk2'
default['spacewalk']['server']['ssl']['org'] = 'Spacewalk Org'
default['spacewalk']['server']['ssl']['org_unit'] = 'spacewalk'
default['spacewalk']['server']['ssl']['city'] = 'My City'
default['spacewalk']['server']['ssl']['state'] = 'My State'
default['spacewalk']['server']['ssl']['country'] = 'US'
default['spacewalk']['server']['ssl']['password'] = 'spacewalk'
default['spacewalk']['server']['ssl']['email'] = 'root@localhost'
default['spacewalk']['server']['ssl']['config_vhost'] = 'Y'
default['spacewalk']['server']['enable_tftp'] = 'Y'

arch = node['kernel']['machine'] == 'x86_64' ? 'x86_64' : 'i386'

case node['platform_family']
when 'rhel'
  platform_major = node['platform_version'][0]
  default['spacewalk']['server']['repo_url'] = "http://yum.spacewalkproject.org/2.7/RHEL/#{platform_major}/#{arch}/spacewalk-repo-2.7-2.el#{platform_major}.noarch.rpm"
when 'fedora'
  default['spacewalk']['server']['repo_url'] = "http://yum.spacewalkproject.org/2.7/Fedora/#{node['platform_version']}/#{arch}/spacewalk-repo-2.7-2.fc#{node['platform_version']}.noarch.rpm"
end

case node['spacewalk']['server']['db']['type']
when 'postgres'
  default['spacewalk']['server']['db']['backend'] = 'postgresql'
  default['spacewalk']['server']['db']['name'] = 'spaceschema'
  default['spacewalk']['server']['db']['user'] = 'spaceuser'
  default['spacewalk']['server']['db']['password'] = 'spacepw'
  default['spacewalk']['server']['db']['host'] = 'localhost'
  default['spacewalk']['server']['db']['port'] = 5432
when 'oracle'
  default['spacewalk']['server']['db']['backend'] = 'oracle'
  default['spacewalk']['server']['db']['name'] = 'xe'
  default['spacewalk']['server']['db']['user'] = 'spacewalk'
  default['spacewalk']['server']['db']['password'] = 'spacewalk'
  default['spacewalk']['server']['db']['host'] = 'localhost'
  default['spacewalk']['server']['db']['port'] = 1521
end

# ::ubuntu configuration
default['spacewalk']['errata']['user'] = 'admin'
default['spacewalk']['errata']['password'] = 'admin'
default['spacewalk']['errata']['exclude-channels'] = "'precise'" # multiple = "'precise','trusty'"
default['spacewalk']['errata']['cron']['h'] = '6'
default['spacewalk']['errata']['cron']['m'] = '0'
