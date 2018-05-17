#
# Cookbook:: kubectl
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Windows is not currently supported

command_name = 'kubectl'
platform = 'linux'
arch = 'amd64'
extension = ''
do_install = true

case node['platform_family'] 
when 'mac_os_x'
	platform = 'darwin'
when 'windows'
	platform = 'windows'
	extension = '.exe'
end

version = node['kubectl']['version']

if version == 'latest'
	uri = URI.parse('https://storage.googleapis.com/kubernetes-release/release/stable.txt')
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true

	request = Net::HTTP::Get.new(uri.request_uri)
	response = http.request(request)

	caps = /v(?<version>[0-9]+\.[0-9]+\.[0-9]+)/.match(response.body)

	version = caps[:version]
end

version = "v#{version}"

# Check to see if kubectl is already installed, and if the version matches.
cmd = "#{node['kubectl']['install_prefix']}#{File::SEPARATOR}#{command_name}#{extension}"

if File.exist?(cmd)
	log "#{cmd} exists, looking for version: #{version}" do
		level :info
	end

	stdout, status = Open3.capture2(cmd, 'version', '--client')
	raise "Failed to execute '#{cmd} version'" unless status.success?

	log "reported version: #{stdout.strip}" do
		level :info
	end

	caps = /Client Version.*GitVersion:"(?<version>v[0-9]+\.[0-9]+\.[0-9]+)".*/.match(stdout.strip)

	if caps[:version] == version
		do_install = false
	end
end

if do_install
	log "installing kubectl to #{node['kubectl']['install_prefix']}" do
		level :info
	end

	directory node['kubectl']['install_prefix'] do
		mode '0755'
		recursive
	end

	remote_file cmd do
		source "#{node['kubectl']['download_base_url']}/#{version}/bin/#{platform}/#{arch}/#{command_name}#{extension}"
		mode '0755'
	end
end
