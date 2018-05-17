
package_url = "#{node.oozie.url}"
base_package_filename = File.basename(package_url)
cached_package_filename = "#{Chef::Config.file_cache_path}/#{base_package_filename}"

remote_file cached_package_filename do
  source package_url
  owner "root"
  mode "0644"
  action :create_if_missing
end

nn = private_recipe_ip("apache_hadoop", "nn") + ":#{node.apache_hadoop.nn.port}"

oozie_downloaded = "#{node.oozie.dir}/.oozie.extracted_#{node.oozie.version}"
# Extract Oozie
bash 'extract_oozie' do
        user "root"
        code <<-EOH
                tar -xf #{cached_package_filename} -C #{node.oozie.dir}
                chown -R #{node.oozie.user}:#{node.oozie.group} #{node.oozie.base_dir}
                cd #{node.oozie.base_dir}
                mkdir libext
                wget -P libext http://dev.sencha.com/deploy/ext-2.2.zip
                rm conf/hadoop-conf/core-site.xml
                rm conf/hadoop-conf/mapred-site.xml
                ln -s #{node.apache_hadoop.base_dir}/etc/hadoop/core-site.xml conf/hadoop-conf/core-site.xml
                ln -s #{node.apache_hadoop.base_dir}/etc/hadoop/mapred-site.xml conf/hadoop-conf/mapred-site.xml
                wget -P libext #{node.hopsworks.mysql_connector_url}
                # bin/oozie-setup.sh sharelib create -fs hdfs://#{nn}
                touch #{oozie_downloaded}
                chown #{node.oozie.user} #{node.oozie.dir}/.oozie.extracted_#{node.oozie.version}
        EOH
     not_if { ::File.exists?( oozie_downloaded ) }
end

file node.oozie.home do
  action :delete
  force_unlink true  
end

link node.oozie.home do
  owner node.oozie.user
  group node.oozie.group
  to node.oozie.base_dir
end

file "#{node.oozie.home}/conf/oozie-site.xml" do
  action :delete
end

# Assume there is a mysql server running on the same host as the Oozie server
private_ip = my_private_ip()

template"#{node.oozie.home}/conf/oozie-site.xml" do
  source "oozie-site.xml.erb"
  owner node.oozie.user
  group node.oozie.group
  mode 0655
  variables({ 
        :mysql_url => "jdbc:mysql://#{private_ip}:#{node.ndb.mysql_port}/oozie"
           })
end


file "#{node.oozie.home}/conf/adminusers.txt" do
  action :delete
end

template "adminusers.txt" do
  source "adminusers.txt.erb"
  owner node.oozie.user
  group node.oozie.group
  mode 0655
end

file "#{node.oozie.home}/conf/oozie-env.sh" do
  action :delete
end

template "oozie-env.sh" do
  source "oozie-env.sh.erb"
  owner node.oozie.user
  group node.oozie.group
  mode 0655
  variables({ 
        :my_ip => private_ip
           })
end



file "#{node.oozie.home}/conf/oozie-default.xml" do
  action :delete
end

template"#{node.oozie.home}/conf/oozie-default.xml" do
  source "oozie-default.xml.erb"
  owner node.oozie.user
  group node.oozie.group
  mode 0655
  variables({ 
        :mysql_url => "jdbc:mysql://#{private_ip}:#{node.ndb.mysql_port}/oozie"
           })
end

template"#{node.oozie.home}/bin/oozie-start.sh" do
  source "oozie-start.sh.erb"
  owner node.oozie.user
  group node.oozie.group
  mode 0755
end

template"#{node.oozie.home}/bin/oozie-stop.sh" do
  source "oozie-stop.sh.erb"
  owner node.oozie.user
  group node.oozie.group
  mode 0755
end


package "zip" do
end
