#
# Cookbook Name:: as-apache2
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#apacheインストール
package 'httpd' do
  action :install
end

# #httpd.conf設定
case node[ :platform ]
  when 'centos'

    template '/etc/httpd/conf/httpd.conf' do
      source node[:platform_version].to_i.to_s + '/httpd.conf.erb'
      mode 0644
      notifies :restart, 'service[httpd]'
      variables({
                    :document_root => node[ :httpd ][ :DocumentRoot ]
                })
    end

    # case node[:platform_version].to_i
    #   when 6
    #     template '/etc/httpd/conf/httpd.conf' do
    #       source '6/httpd.conf.erb'
    #       mode 0644
    #       notifies :restart, 'service[httpd]'
    #       variables({
    #                     :document_root => node[ :httpd ][ :DocumentRoot ]
    #                 })
    #     end
    #   when 7
    #     template '/etc/httpd/conf/httpd.conf' do
    #       source '7/httpd.conf.erb'
    #       mode 0644
    #       notifies :restart, 'service[httpd]'
    #     end
    #   else
    # end

  else
end

#サービス起動＆自動起動
service 'httpd' do
  action [ :enable, :start ]
end
