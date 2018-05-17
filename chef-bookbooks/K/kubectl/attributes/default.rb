default['kubectl']['download_base_url'] = 'https://storage.googleapis.com/kubernetes-release/release'
default['kubectl']['version'] = 'latest'

if node['platform_family'] == 'windows'
	default['kubectl']['install_prefix'] = 'C:\Program Files'
else
	default['kubectl']['install_prefix'] = '/usr/local/bin'
end
