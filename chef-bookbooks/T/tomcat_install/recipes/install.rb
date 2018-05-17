
directory node['tomcat_demo']['temp_dir'] do
       action :create
end

remote_file "#{node['tomcat_demo']['temp_dir']}/#{node['tomcat_demo']['tomcat_pkg']}" do
        source "#{node['tomcat_demo']['remote_path']}/#{node['tomcat_demo']['tomcat_pkg']}"
	mode 0644
        action :create
        not_if {::File.exists?("#{node['tomcat_demo']['temp_dir']}/#{node['tomcat_demo']['tomcat_pkg']}")}
end

tar_tomcat "tar for tomcat package" do
	action :run
	not_if {::File.exists?("#{node['tomcat_demo']['temp_dir']}/#{node['tomcat_demo']['tomcat_file']}")}
end

move "move tomcat folder" do
	action :run
	not_if {::File.exists?("#{node['tomcat_demo']['user_dir']}/#{node['tomcat_demo']['local']}/#{node['tomcat_demo']['tomcat_dir']}")}
end

tomcat_script "startup script" do
	action :run
	only_if {::File.exists?("#{node['tomcat_demo']['user_dir']}/#{node['tomcat_demo']['local']}/#{node['tomcat_demo']['tomcat_dir']}")}
end

passwords = Chef::EncryptedDataBagItem.load("data_bag_name", "tomcat-user")

template "#{node['tomcat_demo']['user_dir']}/#{node['tomcat_demo']['local']}/#{node['tomcat_demo']['tomcat_dir']}/conf/tomcat-users.xml" do
	source "tomcat_users.erb"
	variables({
		:tomcat_user_password => passwords['tomcat_user_password']
	})
	owner 'root'
  	group 'root'
  	mode '0755'
	only_if {::File.exists?( "#{node['tomcat_demo']['user_dir']}/#{node['tomcat_demo']['local']}/#{node['tomcat_demo']['tomcat_dir']}/conf/")}
end
