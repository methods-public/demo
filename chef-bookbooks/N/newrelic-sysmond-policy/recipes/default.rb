# Install node, npm, newrelic-sysmond-policy

if node[:newrelic_sysmond_policy][:installprereqs]
  include_recipe "newrelic"
  include_recipe "nodejs::default"
  nodejs_npm 'newrelic-sysmond-policy'
end

# init.d template
template "/etc/init.d/newrelic-sysmond-policy" do
  source "init_d.erb"
  mode 0755
end

log "NewRelic API key not defined.  Not enabling the service!" do
  level :error
  not_if {node[:newrelic][:apikey]}
end

service "newrelic-sysmond-policy" do
   supports :start => true, :stop => true, :restart => false, :status => false
   priority 90
   action [:enable, :start]
   only_if {node[:newrelic][:apikey]}
end

# Workaround RH/Chef issues described at https://github.com/opscode/chef/issues/2168
execute "newrelic-sysmond-policy-service-centosfix" do
  command "chkconfig newrelic-sysmond-policy reset && service newrelic-sysmond-policy start"
  only_if {node[:newrelic][:apikey] && platform_family?("rhel")}
end
