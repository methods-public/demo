# Activating LogDNA Agent Service:
execute 'update-rc' do
  command 'update-rc.d logdna-agent defaults'
  action :run
end

# Enabling LogDNA Agent Service:
service 'logdna-agent' do
  service_name 'logdna-agent'
  supports status: true, restart: true, start: true, stop: true
  action :enable
end

# Starting LogDNA Agent Service:
service 'logdna-agent' do
  service_name 'logdna-agent'
  supports status: true, restart: true, start: true, stop: true
  action node['logdna']['agent_service']
end
