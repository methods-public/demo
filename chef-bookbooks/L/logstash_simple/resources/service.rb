action :enable do
  service 'logstash' do
    supports :status => true, :restart => true, :reload => true
    action [:enable]
  end
end

action :start do
  service 'logstash' do
    supports :status => true, :restart => true, :reload => true
    action [:start]
  end
end

action :disable do
  service 'logstash' do
    supports :status => true, :restart => true, :reload => true
    action [:disable]
  end
end

action :stop do
  service 'logstash' do
    supports :status => true, :restart => true, :reload => true
    action [:stop]
  end
end
