# @todo just force this and don't care if old chef?
use_inline_resources if respond_to?(:use_inline_resources)

def load_current_resource
  unless(new_resource.user)
    new_resource.user node[:jackal][:user][:name]
  end
end

action :create do
  # Ensure we are setup
  run_context.include_recipe 'jackal::setup'

  new_resource.system_packages.each do |pkg_name|
    package pkg_name
  end

  new_resource.gem_packages.each do |gem_name, gem_version|
    gem_package gem_name do
      if(gem_version)
        version gem_version
      end
      action :install
    end
  end

  configuration_directory = ::File.join(
    node[:jackal][:directories][:configuration],
    new_resource.service_name
  )

  configuration_file = ::File.join(
    configuration_directory,
    "00_#{new_resource.service_name}.json"
  )

  service_name = [
    new_resource.service_prefix,
    new_resource.service_name
  ].compact.join('-')

  directory configuration_directory do
    recursive true
    owner new_resource.user
  end

  file configuration_file do
    content Chef::JSONCompat.to_json_pretty(new_resource.configuration)
    mode 0600
    owner new_resource.user
  end

  new_resource.overrides.each_with_index do |config, idx|
    prefix = sprintf('%02d', idx + 1)
    path = [prefix, 'override.json'].join('_')
    file ::File.join(configuration_directory, path) do
      content Chef::JSONCompat.to_json_pretty(config)
      mode 0600
      owner new_resource.user
      notifies :restart, "service[#{service_name} restarter]"
    end
  end

  # Force mode on all files in directory regardless if we provide them
  Dir.glob(::File.join(configuration_directory, '*')).each do |f|
    file ::File.expand_path(f) do
      mode 0600
      owner new_resource.user
    end
  end

  runit_service service_name do
    run_template_name 'jackal'
    options(
      :config_path => configuration_directory,
      :exec => ::File.join(node[:jackal][:exec_dir], node[:jackal][:exec_name]),
      :user => new_resource.user
    )
    restart_on_update node[:jackal][:enabled][new_resource.service_name]
    default_logger true
    notifies :create, "ruby_block[set enabled #{new_resource.service_name}]"
  end

  service "#{service_name} restarter" do
    service_name service_name
    action :nothing
    only_if{ node[:jackal][:enabled][new_resource.service_name] }
    subscribes :restart, 'ruby_block[jackal_gem_update]'
    subscribes :restart, "file[#{configuration_file}]"
  end

  ruby_block "set enabled #{new_resource.service_name}" do
    block do
      node.set[:jackal][:enabled][new_resource.service_name] = true
    end
    action :nothing
    not_if{ node[:jackal][:enabled][new_resource.service_name] }
  end

end

action :destory do

  configuration_directory = ::File.join(
    node[:jackal][:directories][:configuration],
    new_resource.service_name
  )
  service_name = [
    new_resource.service_prefix,
    new_resource.service_name
  ].compact.join('-')

  runit_service service_name do
    action [:stop, :disable]
  end

  directory configuration_directory do
    action :delete
    recursive true
  end

  node.set[:jackal][:enabled][new_resource.service_name] = false
end
