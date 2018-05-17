supported_versions = node["mecab-python"]["support"].keys
version = node["mecab-python"]["version"]

# You can specify the place of python (maybe it is useful for virtualenv user).
python_path = node["mecab-python"]["python_path"]
python = python_path ? "#{python_path}/python" : "python"
prefix = node["mecab-python"]["conf"]["prefix"] ? "--prefix=#{node["mecab-python"]["conf"]["prefix"]}" : ""

src_filename_noext = "mecab-python-#{version}"
src_filename = "#{src_filename_noext}.tar.gz"
src_filepath = "#{node["dl_site"]["mecab"]}#{src_filename}"
copy_to = "#{Chef::Config[:file_cache_path]}/#{src_filename}"

checksum_type = node["mecab-python"]["support"][version]["checksum_type"]
checksum = node["mecab-python"]["support"][version]["checksum"]

if not supported_versions.include?(version) then
  Chef::Application.fatal!("#{recipe_name} doesn't support the version #{version}")
end

remote_file copy_to do
  source src_filepath
  mode "0644"
  not_if { no_need_to_copy?(checksum_type, copy_to, checksum) }
  notifies :run, 'execute[install mecab-python]', :immediately
end

execute "install mecab-python" do
  action :nothing

  cwd Chef::Config[:file_cache_path]
  command <<-EOD
    tar -zxf #{src_filename}
    cd #{src_filename_noext}
    #{python} setup.py build
    #{python} setup.py install #{prefix}
  EOD
end
