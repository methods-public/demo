

#directory "#{node['tomcat_demo']['temp_dir']}" do
#	action :create
#end

remote_file "#{node['tomcat_demo']['opt_dir']}/#{node['tomcat_demo']['java_pkg']}" do
	source "#{node['tomcat_demo']['remote_path']}/#{node['tomcat_demo']['java_pkg']}"
	mode 0644
	action :create
	not_if {::File.exists?("#{node['tomcat_demo']['opt_dir']}/#{node['tomcat_demo']['java_pkg']}")}
end

tar_java 'extract tar' do
	action :run
	not_if {::File.exists?("#{node['tomcat_demo']['opt_dir']}/#{node['tomcat_demo']['java_file']}")}
end

alternatives 'install java' do
action :run
not_if {::File.exists?("/usr/bin/java")}
end

include_recipe "tomcat_install::install"
