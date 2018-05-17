#
# Cookbook Name:: c-icap
# Attributes:: virus_scan
# Author:: Rostyslav Fridman (<rostyslav.fridman@gmail.com>)
#
# Copyright 2014, Rostyslav Fridman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['c_icap']['virus_scan']['scan_file_types'] = %w{TEXT DATA EXECUTABLE ARCHIVE GIF JPEG MSOFFICE}
default['c_icap']['virus_scan']['send_percent_data'] = 5
default['c_icap']['virus_scan']['start_send_percent_data_after'] = "2M"
default['c_icap']['virus_scan']['allow_204_responces'] = "on"
default['c_icap']['virus_scan']['pass_on_error'] = "on"
default['c_icap']['virus_scan']['max_object_size'] = "5M"

default['c_icap']['clamd']['socket'] = "/tmp/clamd"
default['c_icap']['clamd']['host'] = nil
default['c_icap']['clamd']['port'] = nil
