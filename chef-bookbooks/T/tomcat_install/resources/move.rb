resource_name :move

default_action :run

property :move, String

def move
        cmd = "mv #{node['tomcat_demo']['temp_dir']}/#{node['tomcat_demo']['tomcat_file']} #{node['tomcat_demo']['user_dir']}/#{node['tomcat_demo']['local']}/#{node['tomcat_demo']['tomcat_dir']}"
end

action :run do
execute 'move tomcat directory to user directory' do
   command move
   end
end
