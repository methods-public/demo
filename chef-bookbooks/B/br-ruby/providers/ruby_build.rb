#
# Cookbook Name:: br-ruby
# Provider:: ruby_build
#

provides :ruby_build

use_inline_resources

def whyrun_supported?
  true
end

def runtime
  @runtime ||= BR::Ruby::Runtime.new(new_resource.version, new_resource.install_path)
end

action :install do
  package 'git'

  directory new_resource.path do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    recursive true
  end

  execute 'install ruby-build' do
    command './install.sh'
    cwd new_resource.path
    action :nothing
  end

  git new_resource.path do
    repository new_resource.repository
    revision new_resource.revision
    action :sync
    notifies :run, 'execute[install ruby-build]', :immediately
  end

  execute "ruby-build #{runtime.version} #{runtime.root}" do
    environment new_resource.environment
  end
end
