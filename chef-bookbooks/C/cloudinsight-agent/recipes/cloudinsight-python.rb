#
# Cookbook Name:: cloudinsight-agent
# Recipe:: cloudinsight-python
#


easy_install_package 'cloudinsight' do
  action :install
  options "-i http://pypi.oneapm.com/simple --trusted-host pypi.oneapm.com --upgrade"
end
