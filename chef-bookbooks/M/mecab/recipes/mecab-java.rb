include_recipe 'java'

version = node["mecab-java"]["version"]
src_filename_noext = "mecab-java-#{version}"

if version == 'HEAD'
  revision = 'HEAD'
elsif node['mecab']['ver2rev'].has_key?(version)
  revision = node['mecab']['ver2rev'][version]
else
  raise "Unsupported version string " + version + " for mecab-java"
end

git "cloning mecab repository for java binding" do
  destination "#{Chef::Config[:file_cache_path]}/mecab"
  revision revision
  checkout_branch revision
  enable_checkout false
  timeout 600
  action :export
  #not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/mecab") }

  notifies :run, 'execute[build mecab-java]', :immediately
end

execute "build mecab-java" do
  action :nothing
  cwd "#{Chef::Config[:file_cache_path]}/mecab/mecab/java/"

  command <<-EOD
    make INCLUDE=#{node['java']['java_home']}/include
  EOD
  notifies :run, 'execute[install mecab-java]', :immediately
end

execute "install mecab-java" do
  action :nothing

  command <<-EOD
    cp -r #{Chef::Config[:file_cache_path]}/mecab/mecab/java/ #{node['mecab-java']['install_to']}
  EOD
  not_if { ::File.exists?("#{node['mecab-java']['install_to']}/#{src_filename_noext}") }
end
