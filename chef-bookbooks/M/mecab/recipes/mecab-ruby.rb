version = node["mecab-ruby"]["version"]

need_edit_extconf = false

if version == 'HEAD'
  revision = 'HEAD'
elsif node['mecab']['ver2rev'].has_key?(version)
  revision = node['mecab']['ver2rev'][version]
else
  raise "Unsupported version string " + version + " for mecab-ruby"
end

git "cloning mecab repository for ruby binding" do
  destination "#{Chef::Config[:file_cache_path]}/mecab"
  revision revision
  checkout_branch revision
  enable_checkout false
  timeout 600
  action :export
  #not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/mecab") }

  notifies :run, 'ruby_block[check whether ruby version is under 1.9 or not]', :immediately
end

ruby_block "check whether ruby version is under 1.9 or not" do
  action :nothing
  block do
    ruby_version = `ruby -v`
    ruby_version.match(/ruby (\d).(\d).(\d)/) do |md|
      need_edit_extconf = md[1].to_i == 1 && md[2].to_i < 9
    end
  end
  notifies :run, 'ruby_block[edit extconf.rb]', :immediately
end

ruby_block 'edit extconf.rb' do
  action :nothing

  block do
    if need_edit_extconf then
      fe = Chef::Util::FileEdit.new("#{Chef::Config[:file_cache_path]}/mecab/mecab/ruby/extconf.rb")
      fe.search_file_replace_line(/#include "ruby\/version.h"/)
      fe.write_file
    end
  end
  notifies :run, 'execute[install mecab-ruby]', :immediately
end

execute "install mecab-ruby" do
  action :nothing

  cwd "#{Chef::Config[:file_cache_path]}/mecab/mecab/ruby/"
  command <<-EOD
    ruby extconf.rb 
    make
    make install 
  EOD
end 
