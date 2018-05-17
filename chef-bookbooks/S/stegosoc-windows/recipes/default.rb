#
# Cookbook Name:: stegosoc-windows
# Recipe:: default
#


#Installing Wazuh Agent
windows_package "wazuh agent"  do
	#checksum "8711354d158fe37c4b615ac2db661a11"
	installer_type :custom
	source node['stegosoc']['wazuh']['url']
        action :install
	options '/S'
end


#Configuring ossec agent by creating ossec conf file 

template "C:\\Program Files (x86)\\ossec-agent\\ossec.conf" do
    source "wazuh/ossec-windows.conf.erb"
    owner "Administrator"
    group "Administrator"
    action :create
    variables({
        :manager_ip => node['stegosoc']['wazuh-manager']['ip'],
        :syscheck_frequency => node['stegosoc']['coon']['syscheck_frequency']
        })
end



#Coon registration with ossec manager using agent-authd 


powershell_script "Coon registration" do
cwd "C:\\Program Files (x86)\\ossec-agent" 
code <<-EOH
     & "C:\\Program Files (x86)\\ossec-agent\\agent-auth.exe" -m #{node['stegosoc']['wazuh-manager']['ip']} -p #{node['stegosoc']['wazuh-manager']['port']} -A #{node['stegosoc']['coon']['agent_unique_name']}
EOH
end


#Restart OssecSvc service

windows_service 'OssecSvc' do
   action :restart
end










