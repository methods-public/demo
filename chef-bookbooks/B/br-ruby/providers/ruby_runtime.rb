#
# Cookbook Name:: br-ruby
# Provider:: ruby_runtime
#

provides :ruby_runtime

use_inline_resources

def whyrun_supported?
  true
end

def runtime
  @runtime ||= BR::Ruby::Runtime.new(new_resource.version, new_resource.install_path)
end

def installer
  @installer ||= BR::Ruby::Installer.provider_for(new_resource, run_context)
end

def gems
  @gems ||= new_resource.gems.map do |name, version|
    BR::Ruby::Gem.new(name, version, runtime)
  end
end

action :install do
  return if runtime.installed?

  new_resource.dependencies.each do |dependency|
    package dependency do
      action :install
    end
  end

  directory new_resource.install_path do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    recursive true
  end

  installer.run_action(:install)

  gems.each do |gem|
    execute gem.install_command
  end
end

action :remove do
  return unless runtime.exist?

  directory runtime.root do
    recursive true
    action :delete
  end
end
