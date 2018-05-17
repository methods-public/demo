  bash 'kill_running_service' do
    user "root"
    ignore_failure true
    code <<-EOF
      service stop epipe
      systemctl stop epipe
    EOF
  end

  file "/etc/init.d/epipe" do
    action :delete
    ignore_failure true
  end
  
  file "/usr/lib/systemd/system/epipe.service" do
    action :delete
    ignore_failure true
  end
  file "/lib/systemd/system/epipe.service" do
    action :delete
    ignore_failure true
  end

  directory node[:epipe][:home] do
    recursive true
    action :delete
    ignore_failure true
  end

  link node[:epipe][:base_dir] do
    action :delete
    ignore_failure true
  end


