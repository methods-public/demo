package 'sheepdog'

vars = Mash.new

unless node['sheepdog']['sheep'].nil? && node['sheepdog']['sheep']['options'].nil?
  cmdline = node['sheepdog']['sheep']['options'].map do |k, v|
    case v
    when TrueClass, FalseClass
      if k.length > 1
      then "--#{k}"
      else "-#{k}"
      end
    else
      if k.length > 1
      then "--#{k} #{v}"
      else "-#{k} #{v}"
      end
    end
  end.join(' ')
  vars['args'] = cmdline
end

ohai 'reload' do
  action :reload
end


unless node['sheepdog']['sheep']['iface'].nil?
  addr = `ip -o a s dev #{node['sheepdog']['sheep']['iface']} | grep inet | awk '{print $4}' | cut -d '/' -f1 | head -n 1 | tr -d '\n'`
  if node['sheepdog']['sheep']['options']['bindaddr'].nil? && node['sheepdog']['sheep']['options']['b'].nil?
    vars['args'] = "#{vars['args']} --bindaddr #{addr}"
  end
  if node['sheepdog']['sheep']['options']['myaddr'].nil? && node['sheepdog']['sheep']['options']['y'].nil?
    vars['args'] = "#{vars['args']} --myaddr #{addr}"
  end
end

unless node['sheepdog']['sheep']['storage'].nil?
  storepath = []
  unless node['sheepdog']['sheep']['storage']['meta'].nil?
    storepath.push(node['sheepdog']['sheep']['storage']['meta'])
  end
  unless node['sheepdog']['sheep']['storage']['data'].nil?
    node['sheepdog']['sheep']['storage']['data'].each do |path|
      storepath.push(path)
    end
  end

  vars['path'] = storepath.join(',')

end

service 'sheepdog' do
  action :nothing
end

template '/etc/default/sheepdog' do
  source 'sheep.conf.erb'
  mode 0644
  owner 'root'
  variables(vars: vars)
  action :nothing
  notifies :restart, 'service[sheepdog]', :immediately
end.run_action(:create)

service 'sheepdog' do
  supports status: true, restart: true
  action [:enable, :start]
end

ruby_block "wait for sheep" do
  block do
    i = 0
    while i < 60 do
      system("dog node info -r") && break
      sleep 1
      i += 1
    end
    raise "timeout waiting for sheep" if i > 60
  end
end

unless node['sheepdog']['cluster'].nil?
  node['sheepdog']['cluster'].each do |k, v|
    execute "dog cluster #{k} #{v}" do
      command "dog cluster #{k} #{v}"
    end
  end
end
