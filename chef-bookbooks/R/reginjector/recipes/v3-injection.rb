#
# Author:: Steven Craig <support@smashrun.com>
# Cookbook Name:: reginjector
# Recipe:: v3-injection.rb
#
# Copyright 2013, Smashrun, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

log("begin reginjector") { level :debug }
log("running reginjector") { level :info }

["#{node[:reginjector][:tempdir]}", "#{node[:reginjector][:workingdir]}"].each do |dir|
  directory "#{dir}" do
    action :create
    not_if { File.exists?("#{dir}") }
    recursive true
  end
end


node[:reginjector][:payload].each do |k|

  # execute reg payload file if instructed by a template change
  batch "#{node[:reginjector][:regdeploybat]}_#{k}" do
    cwd "#{node[:reginjector][:tempdir]}"
    code "regedt32.exe /s #{node[:reginjector][:workingdir]}\\#{k}.reg > #{node[:reginjector][:workingdir]}\\reginjector-#{k}.log 2>&1"
    timeout 30
    action :run
    not_if { File.exists?("#{node[:reginjector][:workingdir]}\\reginjector-#{k}.log") }
  end

  # create templated reg payload file for reginjector
  log("create #{node[:reginjector][:workingdir]}\\#{k}.reg if necessary") { level :debug }
  templated = nil
  begin
    templated = resources(:template => "#{k}.reg")
  rescue Chef::Exceptions::ResourceNotFound
    templated = template "#{node[:reginjector][:workingdir]}\\#{k}.reg" do
      source "#{k}.reg.erb"
      variables({
        :author_name => "#{node[:reginjector][:author_name]}",
        :author_email => "#{node[:reginjector][:author_email]}",
        :regeditor_version => "#{node[:reginjector][:regeditor_version]}"
      })
      notifies :run, "batch[#{node[:reginjector][:regdeploybat]}_#{k}]", :immediately
    end
  end

end
log("end reginjector") { level :info }
