node['xvfb']['packages'][node['platform']].each do |pkg|
  package(pkg) { action :install } 
end

template '/etc/init.d/xvfb' do
  source 'xvfb.sh.erb'
  mode 00755
  variables(
    :display => node['xvfb']['display'],
    :screen_number => node['xvfb']['screen']['number'],
    :screen_resolution => node['xvfb']['screen']['resolution'],
    :other_args => node['xvfb']['other_args']
  )
  notifies(:restart, "service[xvfb]")
end

service "xvfb" do
  action [:enable, :start]
end
