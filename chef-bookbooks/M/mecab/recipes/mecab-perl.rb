version = node["mecab-perl"]["version"]

if version == 'HEAD'
  revision = 'HEAD'
elsif node['mecab']['ver2rev'].has_key?(version)
  revision = node['mecab']['ver2rev'][version]
else
  raise "Unsupported version string " + version + " for mecab-python"
end


# You can specify the place of perl (maybe it is useful for virtualenv user).
perl_path = node["mecab-perl"]["perl_path"]
perl = perl_path ? "#{perl_path}/perl" : "perl"

git "cloning mecab repository for perl binding" do
  destination "#{Chef::Config[:file_cache_path]}/mecab"
  revision revision
  checkout_branch revision
  enable_checkout false
  timeout 600
  action :export
  #not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/mecab") }

  notifies :run, 'execute[install mecab-perl]', :immediately
end

execute "install mecab-perl" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}/mecab/mecab/perl/"
  command <<-EOD
    #{perl} Makefile.PL 
    make
    make install
  EOD
end
