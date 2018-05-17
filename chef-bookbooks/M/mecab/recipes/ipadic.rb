include_recipe "mecab::binary"

install_path_prefix = node["mecab"]["prefix"]
mecabrc_path = "#{install_path_prefix}/etc/mecabrc"
version = node['ipadic']['version']

if version == 'HEAD'
  revision = 'HEAD'
elsif node['ipadic']['ver2rev'].has_key?(version)
  revision = node['ipadic']['ver2rev'][version]
else
  raise "Unsupported version string " + version + " for ipadic"
end

configure_cmd = %W{
  ./configure
  --prefix=#{install_path_prefix}
  --with-charset=#{node["mecab"]["charset"]}
}.join(" ")

git "cloning mecab repository for ipadic" do
  destination "#{Chef::Config[:file_cache_path]}/mecab"
  repository node['mecab']['git_repos']
  revision revision
  checkout_branch revision
  enable_checkout false
  timeout 600
  action :export
  #not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/mecab") }

  notifies :run, 'execute[install ipadic]', :immediately
end

execute "install ipadic" do
  action :run
  cwd "#{Chef::Config[:file_cache_path]}/mecab/mecab-ipadic"
  command <<-EOD
    #{configure_cmd}
    make
    make install
  EOD
  #not_if { ::File.exists?("#{install_path_prefix}/lib/mecab/dic/ipadic") }
  notifies :run, 'ruby_block[edit dicdir path in mecabrc]', :immediately
end

# FIXME: Edting configuration file is not the chef way.
ruby_block 'edit dicdir path in mecabrc' do
  action :nothing
  block do
    fe = Chef::Util::FileEdit.new(mecabrc_path)
    fe.search_file_replace_line(/^dicdir = /, "dicdir = #{install_path_prefix}/lib/mecab/dic/ipadic")
    fe.write_file
  end
  not_if { ::File.open(mecabrc_path).read() =~ /dicdir\s+=\s+#{install_path_prefix}\/lib\/mecab\/dic\/ipadic/ }
end

