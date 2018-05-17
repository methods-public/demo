supported_versions = node["mecab-ruby"]["support"].keys
version = node["mecab-ruby"]["version"]

src_filename_noext = "mecab-ruby-#{version}"
src_filename = "#{src_filename_noext}.tar.gz"
src_filepath = "#{node["dl_site"]["mecab"]}#{src_filename}"
copy_to = "#{Chef::Config[:file_cache_path]}/#{src_filename}"

checksum = node["mecab-ruby"]["support"][version]["checksum"]
checksum_type = node["mecab-ruby"]["support"][version]["checksum_type"]

need_edit_extconf = false

if not supported_versions.include?(version) then
  Chef::Application.fatal!("#{recipe_name} doesn't support the version #{version}")
end

remote_file copy_to do
  source src_filepath
  mode "0644"
  not_if { no_need_to_copy?(checksum_type, copy_to, checksum) }
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
  notifies :run, 'execute[extract archive]', :immediately
end

execute "extract archive" do
  action :nothing

  cwd Chef::Config[:file_cache_path]
  command "tar -zxf #{src_filename}"
  notifies :run, 'ruby_block[edit extconf.rb]', :immediately
end

ruby_block 'edit extconf.rb' do
  action :nothing

  block do
    if need_edit_extconf then
      fe = Chef::Util::FileEdit.new("#{Chef::Config[:file_cache_path]}/#{src_filename_noext}/extconf.rb")
      fe.search_file_replace_line(/#include "ruby\/version.h"/)
      fe.write_file
    end
  end
  notifies :run, 'execute[install mecab-ruby]', :immediately
end

execute "install mecab-ruby" do
  action :nothing

  cwd "#{Chef::Config[:file_cache_path]}/#{src_filename_noext}"
  command <<-EOD
    ruby extconf.rb 
    make
    make install 
  EOD
end 
