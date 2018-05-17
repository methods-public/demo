default['maven']['version'] = '3.5.2'
default['maven']['package_name'] = 'apache-maven'
default['maven']['checksum'] = '707b1f6e390a65bde4af4cdaf2a24d45fc19a6ded00fff02e91626e3e42ceaff'
default['maven']['settings_file'] ='settings.xml'
default['maven']['user'] = 'root'
default['maven']['group'] = 'root'
default['maven']['dir_perm'] ='0755'
default['maven']['m2_home'] = "/usr/local/apache-maven-#{node['maven']['version']}"
default['maven']['maven_opts'] ='-Xmx1024m'
default['maven']['url']= 'http://apache.mirrors.tds.net/maven/maven-'+node['maven']['version'].split('.')[0]+"/#{node['maven']['version']}/binaries/apache-maven-#{node['maven']['version']}-bin.tar.gz"
default['maven']['template_cookbook'] = "chef-maven"
