#
# Cookbook:: minikube
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Windows is not currently supported

command_name = 'minikube'
platform = 'linux'
arch = 'amd64'
extension = ''
do_install = true
version = node['minikube']['version'] != 'latest' ? "v#{node['minikube']['version']}" : 'latest'

case node['platform_family'] 
when 'mac_os_x'
	platform = 'darwin'
when 'windows'
	platform = 'windows'
	extension = '.exe'
end

# Check to see if minikube is already installed, and if the version matches.
cmd = "#{node['minikube']['install_prefix']}#{File::SEPARATOR}#{command_name}#{extension}"

if File.exist?(cmd)
	log "#{cmd} exists, looking for version: #{version}" do
		level :info
	end

	stdout, status = Open3.capture2(cmd, 'version')
	raise "Failed to execute '#{cmd} version'" unless status.success?

	log "reported version: #{stdout.strip}" do
		level :info
	end

	if stdout.strip == "minikube version: #{version}"
		do_install = false
	end
end

if do_install
	log "installing minikube to #{node['minikube']['install_prefix']}" do
		level :info
	end

	directory node['minikube']['install_prefix'] do
		mode '0755'
		recursive
	end

	remote_file cmd do
		source "#{node['minikube']['download_base_url']}/#{version}/#{command_name}-#{platform}-#{arch}#{extension}"
		mode '0755'
	end
end
