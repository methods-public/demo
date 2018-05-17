nmy_ip = my_private_ip()
my_public_ip = my_public_ip()

db="oozie"
exec = "#{node.ndb.scripts_dir}/mysql-client.sh"

bash 'create_oozie_db' do
  user "root"
  code <<-EOF
      #{exec} -e \"CREATE DATABASE IF NOT EXISTS oozie CHARACTER SET latin1\"
    EOF
end



tmp_dirs   = ["#{node.apache_hadoop.hdfs.user_home}/#{node.oozie.user}"]
for d in tmp_dirs
 apache_hadoop_hdfs_directory d do
    action :create
    owner node.oozie.user
    group node.oozie.group
    mode "1777"
    not_if ". #{node.apache_hadoop.home}/sbin/set-env.sh && #{node.apache_hadoop.home}/bin/hdfs dfs -test -d #{d}"
  end
end


case node.platform
when "ubuntu"
 if node.platform_version.to_f <= 14.04
   node.override.oozie.systemd = "false"
 end
end


service_name="oozie"

if node.oozie.systemd == "true"

  service service_name do
    provider Chef::Provider::Service::Systemd
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  case node.platform_family
  when "rhel"
    systemd_script = "/usr/lib/systemd/system/#{service_name}.service" 
  else
    systemd_script = "/lib/systemd/system/#{service_name}.service"
  end

  template systemd_script do
    source "#{service_name}.service.erb"
    owner "root"
    group "root"
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :start, resources(:service => service_name), :immediately
  end

  hadoop_spark_start "reload_oozie_daemon" do
    action :systemd_reload
  end  

else #sysv

  service service_name do
    provider Chef::Provider::Service::Init::Debian
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  template "/etc/init.d/#{service_name}" do
    source "#{service_name}.erb"
    owner node.oozie.user
    group node.oozie.group
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :restart, resources(:service => service_name), :immediately
  end

end


if node.kagent.enabled == "true" 
   kagent_config service_name do
     service "YARN"
     start_script "#{node.oozie.home}/bin/oozie-start.sh"
     stop_script "#{node.oozie.home}/bin/oozie-stop.sh"
     log_file "#{node.oozie.home}/logs/oozie.log"
     pid_file "<%= node.oozie.home %>/oozie-server/temp/oozie.pid"
     web_port 11000
   end
end



