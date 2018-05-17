supported_versions = node["mecab-java"]["support"].keys
version = node["mecab-java"]["version"]

src_filename_noext = "mecab-java-#{version}"
src_filename = "#{src_filename_noext}.tar.gz"
src_filepath = "#{node["dl_site"]["mecab"]}#{src_filename}"
copy_to = "#{Chef::Config[:file_cache_path]}/#{src_filename}"

checksum = node["mecab-java"]["support"][version]["checksum"]
checksum_type = node["mecab-java"]["support"][version]["checksum_type"]

if not supported_versions.include?(version) then
  Chef::Application.fatal!("#{recipe_name} doesn't support the version #{version}")
end

remote_file copy_to do
  source src_filepath
  mode "0644"
  not_if { no_need_to_copy?(checksum_type, copy_to, checksum) }
  notifies :run, 'execute[build mecab-java]', :immediately
end

execute "build mecab-java" do
  action :nothing

  cwd Chef::Config[:file_cache_path]
  command <<-EOD
    tar -zxf #{src_filename}
    cd #{src_filename_noext}
    make INCLUDE=#{node['java']['java_home']}/include
  EOD
  notifies :run, 'execute[install mecab-java]', :immediately
end

execute "install mecab-java" do
  action :nothing

  command <<-EOD
    cp -r #{Chef::Config[:file_cache_path]}/#{src_filename_noext} #{node['mecab-java']['install_to']}/
  EOD
  not_if { ::File.exists?("#{node['mecab-java']['install_to']}/#{src_filename_noext}") }
end
