resource_name :tar_java
default_action :run

property :tar_command_java, String

def tar_command_java
	cmd = "cd #{node['tomcat_demo']['opt_dir']} && tar -xzf #{node['tomcat_demo']['opt_dir']}/#{node['tomcat_demo']['java_pkg']}"
end

action :run do
execute 'extract java tarball' do
   command tar_command_java
   end
end

