# ultradns_client_cookbook

Provides ultadns_client LWRP for interaction with the UltraDNS API

## Resources and Providers
###ultradns_client
####Actions
|Action|Description|Default|
|------|-----------|-------|
|create|Create new A or CNAME record|true<|
|update|Update an existing record. Supports modification of the record value or the TTL. To modify a record name, delete the old record and create a new one|false|
|delete|Delete an existing record|false|

####Parameters
|Attribute|Description|Required|Allowed Values|Default|
|---------|-----------|--------|--------------|-------|
|username||Neustar API username||true||Any||None|
|password||Neustar API password||true||Any||None|
|zone||DNS zone to modify. The zone must already exist on the account||true||Any||None|
|record_name||Record to be added / deleted / updated||true||Any||None|
|record_type||Type of record to create. Cannot be used to change an A record to a CNAME||false||A, CNAME||None|
|record_value||IP or other record that the entry should point to||false||Any||None|
|ttl||Record time to live, specified in seconds||false||Integer||300|
|connection_options|Hash of connection options. Currently supports only `host` for overriding the default API endpoint|false||{'host' => 'someapiendpoint'}||{}|

####Examples

Create A record using the test API endpoint

    ultradns_client 'createtest' do
      username node['ultradns_client']['username']
      password node['ultradns_client']['password']
      zone 'api_test.com'
      record_name 'createtest'
      record_type 'A'
      record_value '127.0.0.1'
      ttl 500
      connection_options :host => 'test-restapi.ultradns.com'
      action :create
    end

Update A Record

    ultradns_client 'update-test' do
     username node['ultradns_client']['username']
     password node['ultradns_client']['password']
     zone 'api_test.com'
     record_name 'update-test'
     record_type 'A'
     ttl 200
     action :update
    end

Delete CNAME Record

    ultradns_client 'delete-test' do
      username node['ultradns_client']['username']
      password node['ultradns_client']['password']
      zone 'api_test.com'
      record_name 'delete-test'
      record_type 'CNAME'
      action :delete
    end

## Usage

Include `ultradns_client::default` recipe

## Dependencies
Communication with the API is through ultradns-sdk gem, <https://github.com/ultradns/ultradns-sdk-ruby>

## License and Authors

Author:: Brent Walker (<brent.walker@ge.com>)

Copyright [2015] [General Electric]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
                                                          You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
                    limitations under the License.
