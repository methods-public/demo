#
# Author:: Steven Craig <support@smashrun.com>
# Cookbook Name:: cerberus
# Recipe:: firewall-control.rb
#
# Copyright 2010, Smashrun, Inc.
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

log("begin firewall-control") { level :debug }
log("running firewall-control") { level :info }

begin
  secret = Chef::EncryptedDataBagItem.load_secret("#{node[:twitter][:databag_secret]}")
  twit = Chef::EncryptedDataBagItem.load("#{node[:twitter][:databag]}", "#{node[:twitter][:user]}", secret)
rescue
end

case "#{node[:firewall][:servicestatus]}"
when "restart"
log("service #{node[:firewall][:servicename]} control status change to #{node[:firewall][:servicestatus]} if necessary ") { level :debug }
ruby_block "tweet firewall-control" do
  block {
    if node.run_list.include?("role[twitter]")
      unless WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}"}).nil?
      node[:twitter][:admin].each { |a|
      Tweeter.tweet(a, "#{node[:firewall][:servicename]} on #{node[:hostname]} instructed to #{node[:firewall][:servicestatus]}", twit["consumer_key"], twit["consumer_secret"], twit["oauth_token"], twit["oauth_token_secret"]) }
    end
    end
  }
  ignore_failure true 
end
service "#{node[:firewall][:servicename]}" do
  action :restart
  only_if { WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}"}) }
  supports :restart => true, :stop => true, :start => true, :enable => true, :disable => true
end


when "stop"
log("service #{node[:firewall][:servicename]} control status change to #{node[:firewall][:servicestatus]} if necessary ") { level :debug }
ruby_block "tweet firewall-control" do
  block {
    if node.run_list.include?("role[twitter]")
      unless WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}", :started => "false"})
      node[:twitter][:admin].each { |a|
      Tweeter.tweet(a, "#{node[:firewall][:servicename]} on #{node[:hostname]} instructed to #{node[:firewall][:servicestatus]}", twit["consumer_key"], twit["consumer_secret"], twit["oauth_token"], twit["oauth_token_secret"]) }
    end
    end
  }
  ignore_failure true 
end
service "#{node[:firewall][:servicename]}" do
  action :stop
  only_if { WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}", :started => true}) }
  supports :restart => true, :stop => true, :start => true, :enable => true, :disable => true
end


when "start"
log("service #{node[:firewall][:servicename]} control status change to #{node[:firewall][:servicestatus]} if necessary ") { level :debug }
ruby_block "tweet firewall-control" do
  block {
    if node.run_list.include?("role[twitter]")
      unless WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}", :started => true})
      node[:twitter][:admin].each { |a|
      Tweeter.tweet(a, "#{node[:firewall][:servicename]} on #{node[:hostname]} instructed to #{node[:firewall][:servicestatus]}", twit["consumer_key"], twit["consumer_secret"], twit["oauth_token"], twit["oauth_token_secret"]) }
    end
    end
  }
  ignore_failure true 
end
service "#{node[:firewall][:servicename]}" do
  action :start
  only_if { WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}", :started => false}) }
  supports :restart => true, :stop => true, :start => true, :enable => true, :disable => true
end


when "enable"
log("service #{node[:firewall][:servicename]} control status change to #{node[:firewall][:servicestatus]} if necessary ") { level :debug }
ruby_block "tweet firewall-control" do
  block {
    if node.run_list.include?("role[twitter]")
      unless WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}", :StartMode => "Auto"})
      node[:twitter][:admin].each { |a|
      Tweeter.tweet(a, "#{node[:firewall][:servicename]} on #{node[:hostname]} instructed to #{node[:firewall][:servicestatus]}", twit["consumer_key"], twit["consumer_secret"], twit["oauth_token"], twit["oauth_token_secret"]) }
    end
    end
  }
  ignore_failure true 
end
service "#{node[:firewall][:servicename]}" do
  action :enable
  not_if { WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}", :StartMode =>  "Auto"}) }
  supports :restart => true, :stop => true, :start => true, :enable => true, :disable => true
end


when "disable"
log("service #{node[:firewall][:servicename]} control status change to #{node[:firewall][:servicestatus]} if necessary ") { level :debug }
ruby_block "tweet firewall-control" do
  block {
    if node.run_list.include?("role[twitter]")
      unless WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}", :StartMode => "Disabled"})
      node[:twitter][:admin].each { |a|
      Tweeter.tweet(a, "#{node[:firewall][:servicename]} on #{node[:hostname]} instructed to #{node[:firewall][:servicestatus]}", twit["consumer_key"], twit["consumer_secret"], twit["oauth_token"], twit["oauth_token_secret"]) }
    end
    end
  }
  ignore_failure true 
end
service "#{node[:firewall][:servicename]}" do
  action :disable
  not_if { WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:firewall][:servicename]}", :StartMode =>  "Disabled"}) }
  supports :restart => true, :stop => true, :start => true, :enable => true, :disable => true
end


end


log("end firewall-control") { level :info }
