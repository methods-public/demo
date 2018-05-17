
define :set_document_root do

  template '/etc/httpd/conf/httpd.conf' do
    source node[:platform_version].to_i.to_s + '/httpd.conf.erb'
    mode 0644
    cookbook 'as-apache2'
    notifies :restart, 'service[httpd]'
    variables({
                  :document_root => params[:name]
              })
  end

end
