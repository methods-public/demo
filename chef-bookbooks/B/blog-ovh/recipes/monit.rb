

package 'monit'

service 'monit' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
