#
# Cookbook Name:: omsa
# Recipe:: srvadmin
#
# Copyright 2013, David Meiners
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

if !node['virtualization'] || !node['cloud']
	if node.dmi.system.manufacturer =~ /^dell/i
		include_recipe "omsa::default"
		case node["platform"]
		when "centos"
		  package "srvadmin-all"
		  service "dataeng" do
			action :start
			supports :status => true, :restart => true
		  end
		  service "dsm_om_connsvc" do
			action :start
			supports :status => true, :restart => true
		  end
		  service "dsm_om_shrsvc" do
			action :start
			supports :status => true, :restart => true
		  end
		  service "dsm_sa_ipmi" do
			action :start
			supports :status => true, :restart => true
		  end
		end
	end
end
