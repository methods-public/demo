default['minikube']['download_base_url'] = 'https://storage.googleapis.com/minikube/releases'
default['minikube']['version'] = 'latest'

if node['platform_family'] == 'windows'
	default['minikube']['install_prefix'] = 'C:\Program Files'
else
	default['minikube']['install_prefix'] = '/usr/local/bin'
end
