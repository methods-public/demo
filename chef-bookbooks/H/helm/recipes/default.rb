#
# Cookbook:: helm
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
require "net/https"
require "uri"

command_name = 'helm'
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

version = node['helm']['version']

if version == 'latest'
	uri = URI.parse('https://github.com/kubernetes/helm/releases')
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true

	request = Net::HTTP::Get.new(uri.request_uri)
	response = http.request(request)

	caps = /.*v(?<version>[0-9]+\.[0-9]+\.[0-9]+).*/.match(response.body)

	version = caps[:version]
end

version = "v#{version}"
archive = "#{command_name}-#{version}-#{platform}-#{arch}#{node['platform_family'] == 'windows' ? '.zip' : '.tar.gz'}"

# Check to see if helm is already installed, and if the version matches.
cmd = "#{node['helm']['install_prefix']}#{File::SEPARATOR}#{command_name}#{extension}"

if File.exist?(cmd)
	log "#{cmd} exists, looking for version: #{version}" do
		level :info
	end

	stdout, status = Open3.capture2(cmd, 'version')
	raise "Failed to execute '#{cmd} version'" unless status.success?

	log "reported version: #{stdout.strip}" do
		level :info
	end

	if stdout.strip.start_with? "Client: &version.Version{SemVer:\"#{version}\""
		do_install = false
	end
end

if do_install
	log "installing helm to #{node['helm']['install_prefix']}" do
		level :info
	end

	directory node['helm']['install_prefix'] do
		mode '0755'
		recursive
	end

	# Run this after extracting the archive to a temp location
	ruby_block 'copy helm' do
		action :nothing
		block do
			File.rename("#{Dir.tmpdir}#{File::SEPARATOR}helm#{File::SEPARATOR}/helm#{extension}", cmd)
		end
	end

	directory "#{Dir.tmpdir}#{File::SEPARATOR}helm"

	# Downloads and extracts the archive to a temp location
	poise_archive "#{node['helm']['download_base_url']}/#{archive}" do
		destination "#{Dir.tmpdir}#{File::SEPARATOR}helm"
		notifies :run, 'ruby_block[copy helm]', :immediately
	end
end
