# Activating LogDNA Agent Service:
execute 'chkconfig' do
  command 'chkconfig logdna-agent on'
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
