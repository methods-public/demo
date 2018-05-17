include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

oneapm_ci_agent_monitor 'lighttpd' do
  instances node['oneapm-ci-agent']['lighttpd']['instances']
end
