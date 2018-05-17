default['helm']['download_base_url'] = 'https://storage.googleapis.com/kubernetes-helm'
default['helm']['version'] = 'latest'

if node['platform_family'] == 'windows'
	default['helm']['install_prefix'] = 'C:\Program Files'
else
	default['helm']['install_prefix'] = '/usr/local/bin'
end
