#
# Cookbook Name:: hana-studio
# Resource:: sap_media
#
# Copyright 2016, SAP
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

actions :extract
default_action :extract

attribute :extractDir,  :kind_of => String, :name_attribute => true
attribute :remote_path, :kind_of => String
attribute :sapcar,      :kind_of => String
