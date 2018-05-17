directory '/opt/spacewalk' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# install scripts/crons for errata import
if node['spacewalk']['server']['errata']
  cookbook_file '/opt/spacewalk/parseUbuntu.py' do
    source 'parseUbuntu.py'
    owner 'root'
    group 'root'
    mode '0755'
  end

  template '/opt/spacewalk/errata-import.py' do
    source 'errata-import.py.erb'
    owner 'root'
    group 'root'
    mode '755'
    variables(user: node['spacewalk']['errata']['user'],
              pass: node['spacewalk']['errata']['password'],
              server: node['spacewalk']['hostname'],
              exclude: node['spacewalk']['errata']['exclude-channels'])
  end

  template '/opt/spacewalk/spacewalk-errata.sh' do
    source 'spacewalk-errata-ubuntu.sh.erb'
    owner 'root'
    group 'root'
    mode '0755'
  end

  cron 'sw-errata-import' do
    hour node['spacewalk']['errata']['cron']['h']
    minute node['spacewalk']['errata']['cron']['m']
    command '/opt/spacewalk/spacewalk-errata.sh'
  end

  directory '/opt/spacewalk/errata' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end
