action :install do
windows_package 'SkypeSetup' do
  @attribute = String.new()
  @attribute << " INSTALLDIR=#{new_resource.install_directory}" 
  @attribute << " ALLUSERS=#{new_resource.all_users}"
  source node[:skype][:source]
  options @attribute
  action :install
end
end

 


