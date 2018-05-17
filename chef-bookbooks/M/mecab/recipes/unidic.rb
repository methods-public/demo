include_recipe "mecab::binary"

supported_versions = node["unidic"]["support"].keys
version = node["unidic"]["version"]

src_filename_noext = "unidic-mecab-#{version}_src"
src_filename = "#{src_filename_noext}.zip"
src_filepath = "http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Funidic%2F58338%2F#{src_filename}"
copy_to = "#{Chef::Config[:file_cache_path]}/#{src_filename}"

checksum = node['unidic']['support'][version]['checksum']
checksum_type = node['unidic']['support'][version]['checksum_type']

install_path_prefix = node["mecab"]["prefix"]
mecabrc_path = "#{install_path_prefix}/etc/mecabrc"

configure_cmd = %W{
  ./configure
  --prefix=#{install_path_prefix}
}.join(" ")

if not supported_versions.include?(version) then
  Chef::Application.fatal!("#{recipe_name} doesn't support the version #{version}")
end

remote_file copy_to do
  source src_filepath
  mode "0644"
  notifies :run, 'execute[install unidic]', :immediately

  # Skip download/make/install if system already has UniDic regardless of its version.
  not_if { ::File.exists?("#{install_path_prefix}/lib/mecab/dic/unidic") }
  not_if { no_need_to_copy?(checksum_type, copy_to, checksum) }
end

execute "install unidic" do
  action :nothing
  cwd Chef::Config[:file_cache_path]
  command <<-EOD
    unzip #{src_filename}
    cd #{src_filename_noext}
    #{configure_cmd}
    make
    make install
  EOD
  notifies :run, 'ruby_block[edit dicdir path in mecabrc]', :immediately
end

# FIXME: Edting configuration file is not the chef way.
ruby_block 'edit dicdir path in mecabrc' do
  action :nothing
  block do
    fe = Chef::Util::FileEdit.new(mecabrc_path)
    fe.search_file_replace_line(/^dicdir = /, "dicdir = #{install_path_prefix}/lib/mecab/dic/unidic")
    fe.write_file
  end
  not_if { ::File.open(mecabrc_path).read() =~ /dicdir\s+=\s+#{install_path_prefix}\/lib\/mecab\/dic\/unidic/ }
end
