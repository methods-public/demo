version = node["mecab-python"]["version"]

if version == 'HEAD'
  revision = 'HEAD'
elsif node['mecab']['ver2rev'].has_key?(version)
  revision = node['mecab']['ver2rev'][version]
else
  raise "Unsupported version string " + version + " for mecab-python"
end

prefix = node["mecab-python"]["prefix"] ? "--prefix=#{node["mecab-python"]["prefix"]}" : ""
dev_include_path = node["mecab-python"]["python_dev_include_path"] ? node["mecab-python"]["python_dev_include_path"] : ""
env = "env CPLUS_INCLUDE_PATH=#{dev_include_path}"

execute 'workaround for centos' do
  action :run
  command "ln -s #{node['mecab-python']['python_dev_lib_path']} /usr/local/lib/"
  not_if { node["mecab-python"]["python_dev_lib_path"] == nil }
  not_if { ::File.exists?("/usr/local/lib/libpython*.so") }
  only_if { ::File.exists?(node["mecab-python"]["python_dev_lib_path"]) }
  only_if { node[:platform] == "centos" }
end

git "cloning mecab repository for python binding" do
  destination "#{Chef::Config[:file_cache_path]}/mecab"
  revision revision
  checkout_branch revision
  enable_checkout false
  timeout 600
  action :export
  #not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/mecab") }

  notifies :run, 'execute[build mecab-python]', :immediately
end

execute 'build mecab-python' do
  action :nothing
  cwd "#{Chef::Config[:file_cache_path]}/mecab/mecab/python/"
  command "#{env} python #{Chef::Config[:file_cache_path]}/mecab/mecab/python/setup.py build"
  notifies :run, 'execute[install mecab-python]', :immediately
end

execute 'install mecab-python' do
  action :nothing
  cwd "#{Chef::Config[:file_cache_path]}/mecab/mecab/python/"
  command "python #{Chef::Config[:file_cache_path]}/mecab/mecab/python/setup.py install #{prefix}"
end
