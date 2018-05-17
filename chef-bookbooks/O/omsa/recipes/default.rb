#
# Cookbook Name:: omsa
# Recipe:: default
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
		case node["platform"]
		when "centos"  
		  yum_key "RPM-GPG-KEY-dell" do
		    url  "http://linux.dell.com/repo/hardware/OMSA_7.3.1/RPM-GPG-KEY-dell"
		    action :add
		  end
		  yum_key "RPM-GPG-KEY-libsmbios" do
		    url  "http://linux.dell.com/repo/hardware/OMSA_7.3.1/RPM-GPG-KEY-libsmbios"
		    action :add
		  end
		  yum_repository "dell-omsa-indep" do
		    description "Dell OMSA repository - Hardware independent"
		    key node['omsa']['key']
		    mirrorlist node['omsa']['indep']['mirrorlist']
		    includepkgs node['omsa']['indep']['includepkgs']
		    exclude node['omsa']['indep']['exclude']
		    action :add
		  end
		  yum_repository "dell-omsa-specific" do
		    description "Dell OMSA repository - Hardware specific"
		    key node['omsa']['key']
		    mirrorlist node['omsa']['specific']['mirrorlist']
		    includepkgs node['omsa']['specific']['includepkgs']
		    exclude node['omsa']['specific']['exclude']
		    action :add
		  end
		  package "yum-dellsysid"
		end
	end
end
