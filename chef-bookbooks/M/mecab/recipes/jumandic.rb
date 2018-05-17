include_recipe "mecab::binary"

install_path_prefix = node["mecab"]["prefix"]
mecabrc_path = "#{install_path_prefix}/etc/mecabrc"
version = node['jumandic']['version']

if version == 'HEAD'
  revision = 'HEAD'
elsif node['jumandic']['ver2rev'].has_key?(version)
  revision = node['jumandic']['ver2rev'][version]
else
  raise "Unsupported version string " + version + " for jumandic"
end

configure_cmd = %W{
  ./configure
  --prefix=#{install_path_prefix}
  --with-charset=#{node["mecab"]["charset"]}
}.join(" ")

git "cloning mecab repository for jumandic" do
  destination "#{Chef::Config[:file_cache_path]}/mecab"
  repository node['mecab']['git_repos']
  revision revision
  timeout 600
  action :export
  #not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/mecab") }

  notifies :run, 'execute[install jumandic]', :immediately
end


execute "install jumandic" do
  action :nothing
  cwd "#{Chef::Config[:file_cache_path]}/mecab/mecab-jumandic"
  command <<-EOD
    #{configure_cmd}
    make
    make install
  EOD
  #not_if { ::File.exists?("#{install_path_prefix}/lib/mecab/dic/jumandic") }
  notifies :run, 'ruby_block[edit dicdir path in mecabrc]', :immediately
end

# FIXME: Edting configuration file is not the chef way.
ruby_block 'edit dicdir path in mecabrc' do
  action :nothing
  block do
    fe = Chef::Util::FileEdit.new(mecabrc_path)
    fe.search_file_replace_line(/^dicdir = /, "dicdir = #{install_path_prefix}/lib/mecab/dic/jumandic")
    fe.write_file
  end
  not_if { ::File.open(mecabrc_path).read() =~ /dicdir\s+=\s+#{install_path_prefix}\/lib\/mecab\/dic\/jumandic/ }
end
