#
# Cookbook Name:: as_php
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum-epel::default'
include_recipe 'yum-remi::default'

# yum_repository 'epel' do
#   enabled false
# end

# %w{epel epel-debuginfo epel-source epel-testing epel-testing-debuginfo epel-testing-source}.each do |item|
#   yum_repository item do
#     enabled false
#   end
# end

# %w{epel remi}.each do |item|
#   yum_repository item do
#     enabled false
#   end
# end

log 'Platform Family:' + node[ :platform_family ]
log 'Platform Version:' + node[ :platform_version]
log 'PHP Version:' + node[ :php ][ :version ]

case node[ :platform_family ]
  when 'rhel'

    case node[:platform_version].to_i

      when 6

        case node[ :php ][ :version ]
          when '5.3'

            #phpインストール
            list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysql php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-process php-intl)
            package list do
              action :install
              # options '--enablerepo=base'
              options '--disablerepo=remi'
            end

            #php.ini配置
            template '/etc/php.ini' do
              source 'php53/php.ini.erb'
              mode 0644
              # notifies :restart, 'service[httpd]'
            end

          when '5.4'

            #phpインストール
            list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysql php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-process php-intl)
            package list do
              action :install
              options '--enablerepo=remi'
            end

            #php.ini配置
            template '/etc/php.ini' do
              source 'php54/php.ini.erb'
              mode 0644
              # notifies :restart, 'service[httpd]'
            end

          when '5.5'

            #gd-lastインストール（php-gdで必要）
            package 'gd-last' do
              action :install
              options '--enablerepo=remi'
            end

            #phpインストール
            list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysqlnd php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-opcache php-process php-intl)
            package list do
              action :install
              options '--enablerepo=remi-php55'
            end

            #php.ini配置
            template '/etc/php.ini' do
              source 'php55/php.ini.erb'
              mode 0644
              # notifies :restart, 'service[httpd]'
            end

          when '5.6'

            #gd-lastインストール（php-gdで必要）
            package 'gd-last' do
              action :install
              options '--enablerepo=remi'
            end

            #phpインストール
            list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysqlnd php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-opcache php-process php-intl)
            package list do
              action :install
              options '--enablerepo=remi-php56'
            end

            #php.ini配置
            template '/etc/php.ini' do
              source 'php56/php.ini.erb'
              mode 0644
              # notifies :restart, 'service[httpd]'
            end

          else
        end

      when 7

        case node[ :php ][ :version ]
          when '5.4'


            #phpインストール
            list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysql php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-process php-intl)
            package list do
              action :install
              options '--enablerepo=base'
            end

            # #レポジトリ無効
            # %w{remi remi-php55 remi-php56}.each do |item|
            #   yum_repository item do
            #     enabled false
            #   end
            # end
            # #レポジトリremi有効
            # %w{epel remi}.each do |item|
            #   yum_repository item do
            #     enabled true
            #   end
            # end
            #
            # #phpインストール
            # # list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysql php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-pecl-apc php-process php-intl)
            # list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysql php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-process php-intl)
            # package list do
            #   action :install
            # end

            #php.ini配置
            template '/etc/php.ini' do
              source 'php54/php.ini.erb'
              mode 0644
              # notifies :restart, 'service[httpd]'
            end

          when '5.5'

            #gd-lastインストール（php-gdで必要）
            package 'gd-last' do
              action :install
              options '--enablerepo=remi'
            end

            #phpインストール
            list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysqlnd php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-opcache php-process php-intl)
            package list do
              action :install
              options '--enablerepo=remi-php55'
            end

            # #gd-lastインストール
            # %w{remi}.each do |item|
            #   yum_repository item do
            #     enabled true
            #   end
            # end
            # package 'gd-last' do
            #   action :install
            # end
            #
            # #レポジトリ無効
            # %w{remi remi-php56}.each do |item|
            #   yum_repository item do
            #     enabled false
            #   end
            # end
            # #レポジトリremi-php55有効
            # %w{epel remi-php55}.each do |item|
            #   yum_repository item do
            #     enabled true
            #   end
            # end
            #
            # #phpインストール
            # list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysqlnd php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-opcache php-process php-intl)
            # package list do
            #   action :install
            # end

            #php.ini配置
            template '/etc/php.ini' do
              source 'php55/php.ini.erb'
              mode 0644
              # notifies :restart, 'service[httpd]'
            end

          when '5.6'

            #gd-lastインストール（php-gdで必要）
            package 'gd-last' do
              action :install
              options '--enablerepo=remi'
            end

            #phpインストール
            list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysqlnd php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-opcache php-process php-intl)
            package list do
              action :install
              options '--enablerepo=remi-php56'
            end


            # #gd-lastインストール
            # %w{remi}.each do |item|
            #   yum_repository item do
            #     enabled true
            #   end
            # end
            # package 'gd-last' do
            #   action :install
            # end
            #
            # #レポジトリ無効
            # %w{remi remi-php55}.each do |item|
            #   yum_repository item do
            #     enabled false
            #   end
            # end
            # #レポジトリremi-php56有効
            # %w{epel remi-php56}.each do |item|
            #   yum_repository item do
            #     enabled true
            #   end
            # end
            #
            # #phpインストール
            # list = %w(php php-cli php-common php-pdo php-mbstring php-pecl-memcache php-mysqlnd php-devel php-pgsql php-pear php-gd php-xml php-pecl-xdebug php-opcache php-process php-intl)
            # package list do
            #   action :install
            # end

            #php.ini配置
            template '/etc/php.ini' do
              source 'php56/php.ini.erb'
              mode 0644
              # notifies :restart, 'service[httpd]'
            end

          else
        end
      else

    end

  else
end

