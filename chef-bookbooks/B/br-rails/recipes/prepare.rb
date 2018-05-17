#
# Cookbook Name:: br-rails
# Recipe:: prepare
#

extend BR::Rails::Recipe

applications.each do |name, application|
  application['dependencies'].each do |name|
    package name do
      action :install
    end
  end

  directory application['root'] do
    owner application['owner']
    group application['group']
    mode application['mode']

    not_if { ::File.exist? application['root'] }

    recursive true
  end

  git application['root'] do
    repository application['git']['repository']
    revision application['git']['revision']
    user application['owner']
    group application['group']

    only_if { application['git']['repository'] }

    action :sync
  end
end
