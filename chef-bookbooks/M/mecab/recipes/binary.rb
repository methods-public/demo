version = node['mecab']['version']

if version == 'HEAD'
  revision = 'HEAD'
elsif node['mecab']['ver2rev'].has_key?(version)
  revision = node['mecab']['ver2rev'][version]
else
  raise "Unsupported version string " + version + " for mecab"
end

configure_cmd = %W{
  ./configure
  #{node['mecab']['prefix'] ? "--prefix=#{node['mecab']['prefix']}" : ""}
  #{node['mecab']['charset'] ? "--with-charset=#{node['mecab']['charset']}" : ""}
  #{node['mecab']['utf8-only'] ? '--enable-utf8-only' : ''}
}.join(' ')

if node[:platform] == "debian" and node[:platform_version] == "7.8" then
  package 'libtool' do
    action :install
  end
end

git "cloning mecab repository for mecab app" do
  destination "#{Chef::Config[:file_cache_path]}/mecab"
  repository node['mecab']['git_repos']
  revision revision
  checkout_branch revision
  enable_checkout false
  action :export
  timeout node['mecab']['clone_timeout']
  not_if 'which mecab'
  notifies :run, 'execute[make && make install MeCab]', :immediately
end

execute 'make && make install MeCab' do
  action :nothing
  cwd "#{Chef::Config[:file_cache_path]}/mecab/mecab"
  command <<-EOD
              #{configure_cmd}
              mkdir m4 # workaround
              make
              make check
              make install
            EOD
  notifies :run, 'ruby_block[edit ld.so.conf]', :immediately
end

# FIXME: Edting configuration file is not the chef way.
ruby_block 'edit ld.so.conf' do
  action :nothing
  block do
    p = "#{node['mecab']['prefix']}/lib"
    fe = Chef::Util::FileEdit.new('/etc/ld.so.conf')
    fe.insert_line_if_no_match(/p/, p)
    fe.write_file
  end
  not_if "ldconfig -p | grep #{node['mecab']['prefix']}/local/lib"
  not_if { !platform_family?('debian', 'rhel') }
  notifies :run, 'execute[ldconfig]', :immediately
end

execute 'ldconfig' do
  command 'ldconfig'
  action :nothing
end
