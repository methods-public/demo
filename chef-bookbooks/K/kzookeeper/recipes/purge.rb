bash 'kill_running_service' do
  user "root"
  ignore_failure true
  code <<-EOF
      service stop zookeeper
      systemctl stop zookeeper
    EOF
end

file "/etc/init.d/zookeeper" do
  action :delete
  ignore_failure true
end

file "/usr/lib/systemd/system/zookeeper.service" do
  action :delete
  ignore_failure true
end
file "/lib/systemd/system/zookeeper.service" do
  action :delete
  ignore_failure true
end

directory node[:kzookeeper][:home] do
  recursive true
  action :delete
  ignore_failure true
end

link node[:kzookeeper][:base_dir] do
  action :delete
  ignore_failure true
end


