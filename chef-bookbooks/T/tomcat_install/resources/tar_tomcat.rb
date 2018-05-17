resource_name :tar_tomcat
default_action :run
property :tar_command_tomcat, String

def tar_command_tomcat
        cmd = "cd #{node['tomcat_demo']['temp_dir']} && tar -xzf #{node['tomcat_demo']['temp_dir']}/#{node['tomcat_demo']['tomcat_pkg']}"
end

action :run do
   execute 'extract tomcat tarball' do
   command tar_command_tomcat
   end
end

