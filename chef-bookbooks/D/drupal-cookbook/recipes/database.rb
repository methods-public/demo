# Copyright 2015 Gabor Takacs

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Configure the mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  	action :install
end

# Configure the MySQL client.
mysql_client 'default' do
  	action :create
end

# Configure the MySQL service.
mysql_service 'default' do
  	initial_root_password node['drupal-cookbook']['install']['db_pass']
  	action [:create, :start]
end

# Create the database instance.
mysql_database node['drupal-cookbook']['db']['dbname'] do
  connection(
    :host => node['drupal-cookbook']['db']['host'],
    :username => node['drupal-cookbook']['install']['db_user'],
    :password => node['drupal-cookbook']['install']['db_pass']
  )
  action :create
end
