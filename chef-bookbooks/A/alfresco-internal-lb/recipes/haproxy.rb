enable_rsyslog_server = node['internal_lb']['enable_rsyslog_server']
rsyslog_bind = node['haproxy']['rsyslog_bind']

create_certs 'Creation of haproxy certs' do
  ssl_filename node['internal_lb']['certs']['filename']
  ssl_fqdn node['internal_lb']['hostname']
  ssl_folder node['internal_lb']['certs']['ssl_folder']
  ssl_databag node['internal_lb']['certs']['databag_name']
  ssl_databag_item node['internal_lb']['certs']['databag_item']
  skip_certificate_creation node['internal_lb']['certs']['skip_certificate_creation']

  action :run
end

include_recipe 'commons::error-pages'

if node['internal_lb']['enable_ssl_header']
  node.default['haproxy']['frontends']['external']['headers'] = [node['haproxy']['ssl_header']]
  node.default['haproxy']['backends']['share']['secure_entries'] = node['haproxy']['secure_entries']
end

# Install haproxy discovery
install_haproxy_discovery = node['internal_lb']['ec2']['install_haproxy_discovery']
if install_haproxy_discovery
  template node['haproxy']['ec2']['discovery_chef_erb'] do
    source 'haproxy/haproxy-discovery.cron.erb'
  end
  template node['haproxy']['ec2']['discovery_chef_json'] do
    source 'haproxy/haproxy-discovery.json.erb'
  end
end

if node['internal_lb']['logging_json_enabled']
  node.default['haproxy']['logformat'] = node['haproxy']['json_logformat']
end

include_recipe 'haproxy::default'

selinux_commands = {}
# selinux_commands["mkdir -p /var/www/html/errors ; semanage fcontext -a -t haproxy_var_run_t \"/var/www/html/errors(/.*)\?\" ; restorecon -Rv /var/www/html/errors;"]  = "ls -lZ /var/www/html/errors | grep haproxy_var_run_t"
# selinux_commands["touch /var/run/haproxy.stat ; semanage fcontext -a -t haproxy_var_run_t \"/var/run/haproxy\\.stat.*\" ; restorecon -Rv /var/run/haproxy.stat;"] = "ls -lZ /var/run/haproxy.stat | grep haproxy_var_run_t"
# selinux_commands["semanage port -m -t http_port_t -p tcp 9001"] = "semanage port -l | grep http_port_t | grep 9001"
# selinux_commands["semanage port -m -t http_port_t -p tcp 1936"] = "semanage port -l | grep http_port_t | grep 1936"
selinux_commands['semanage permissive -a haproxy_t'] = 'semanage permissive -l | grep haproxy_t'

# TODO: make it a custom resource
selinux_commands.each do |command, already_permissive|
  execute "selinux-command-#{command}" do
    command command
    only_if 'getenforce | grep -i enforcing'
    only_if 'which semanage'
    not_if already_permissive
  end
end

include_recipe 'alfresco-internal-lb::haproxy-config'

# TODO: rsyslog stuff should go somewhere else (not sure where)

# Haproxy rsyslog configuration
directory '/var/log/haproxy' do
  action :create
  owner 'haproxy'
  group 'haproxy'
end
template '/etc/rsyslog.d/haproxy.conf' do
  source 'rsyslog/haproxy.conf.erb'
  only_if { node['haproxy']['enable_local_logging'] }
end

# TODO: this block can be contributed to a lib cookbook, somewhere
# Make sure Rsyslog is configured to receive Haproxy logs
if enable_rsyslog_server && File.exist?('/etc/rsyslog.conf')
  lines_to_append = [
    ['$ModLoad imudp', nil],
    ["$UDPServerAddress #{rsyslog_bind}", '$UDPServerAddress'],
    ['$UDPServerRun 514","$UDPServerRun']
  ]

  lines_to_append.each do |line|
    new_line = line[0]
    line_match = line[1]
    line_match = new_line if line_match.nil?
    replace_or_add "rsyslog-conf-#{line}" do
      path '/etc/rsyslog.conf'
      pattern line_match
      line new_line
      notifies :restart, 'service[rsyslog]', :delayed
    end
  end

  service 'rsyslog' do
    action :nothing
  end
end
