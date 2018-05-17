resource_name :tomcat_script
default_action :run
property :tomcat_script, String

def tomcat_script
        cmd = "cd #{node['tomcat_demo']['user_dir']}/#{node['tomcat_demo']['local']}/#{node['tomcat_demo']['tomcat_dir']} && ./#{node['tomcat_demo']['bin_dir']}/startup.sh"
end

action :run do
execute 'run startup script of tomcat' do
   command tomcat_script
   end
end

