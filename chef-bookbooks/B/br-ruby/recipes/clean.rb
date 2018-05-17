#
# Cookbook Name:: br-ruby
# Recipe:: clean
#

installed_runtimes = BR::Ruby::Runtime.installed_at(node['ruby']['install_path'])

installed_runtimes.each do |runtime|
  ruby_runtime runtime.version do
    install_path node['ruby']['install_path']
    not_if { node['ruby']['versions'].include?(runtime.version) }
    action :remove
  end
end
