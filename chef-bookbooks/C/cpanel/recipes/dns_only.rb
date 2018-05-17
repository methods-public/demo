#
##

# Prepare server for dns only setup
execute 'cpanel-dnsonly' do
  command '/bin/sh latest-dnsonly'
  cwd '/home'
  action :nothing
end

execute 'hostname_refresh' do
  command "hostname #{node['fqdn']}"
  action :nothing
end

if not ::File.exist?('/var/cpanel')
  if not ::File.exist?('/var/cpanel/dnsonly')
    file '/etc/hostname' do
      content node['fqdn']
      notifies :run, 'execute[hostname_refresh]', :immediately
    end
    remote_file '/home/latest-dnsonly' do
      source 'https://securedownloads.cpanel.net/latest-dnsonly'
      action :create
      not_if ::File.exist?('/var/cpanel/dnsonly')
      notifies :run, 'execute[cpanel-dnsonly]', :immediately
    end
  end
end
