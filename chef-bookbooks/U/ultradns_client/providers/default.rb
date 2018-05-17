# Copyright [2015] [General Electric]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
#                                                           You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#                     limitations under the License.

use_inline_resources

def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::UltradnsClient.new(new_resource.name)
  @current_resource.username(new_resource.username)
  @current_resource.password(new_resource.password)
  @current_resource.zone(new_resource.zone)
  @current_resource.connection_options(new_resource.connection_options)

  # check if the record already exists
  rrsets = get_zone.rrsets.parsed_response['rrSets']
  owner_name = build_ownername(new_resource.record_name, new_resource.zone)
  cr_index = rrsets.find_index { |record| record['ownerName'].eql? owner_name }
  current_record = rrsets[cr_index] unless cr_index.nil?

  if current_record.nil?
    @record_exists = false
  else
    Chef::Log.debug("Record exists: #{current_record}")

    @record_exists = true
    @current_resource.record_name(new_resource.record_name)
    @current_resource.record_type(map_rrtype(current_record['rrtype']))
    @current_resource.record_value(map_rdata(current_record['rdata']))
    @current_resource.ttl(current_record['ttl'])
  end

  @current_resource
end

action :create do
  # If there is already a record for the same name, don't try and create
  unless @record_exists
    converge_by("Create #{new_resource.record_type} record in zone #{new_resource.zone}: #{new_resource.record_name} = #{new_resource.record_value} - #{new_resource.ttl}") do
      zone = get_zone
      Chef::Log.debug("zone.rrset(#{new_resource.record_type}, #{new_resource.record_name}).create(#{new_resource.ttl}, #{[new_resource.record_value]})")
      response = zone.rrset(new_resource.record_type, new_resource.record_name).create(new_resource.ttl, [new_resource.record_value])

      Chef::Log.debug("Create response: #{response}")
      check_response(response, 'Failed to create new record.')
    end
  end
end

action :update do
  if @record_exists
    # record exists, check to see if it matches before changing
    unless current_resource.record_value.eql? new_resource.record_value && current_resource.ttl == new_resource.ttl
      converge_by("Modify #{new_resource.record_type} record in zone #{new_resource.zone}: #{new_resource.record_name} = #{new_resource.record_value} - #{new_resource.ttl}") do
        response = get_zone.rrset(new_resource.record_type, new_resource.record_name).update(new_resource.ttl, [new_resource.record_value])

        Chef::Log.debug("Modify Response: #{response}")
        check_response(response, 'Failed to modify record.')
      end
    end
  end
end

action :delete do
  if @record_exists
    converge_by("Delete #{new_resource.record_type} record in zone #{new_resource.zone}: #{new_resource.record_name}") do
      Chef::Log.debug("get_zone.rrset(#{new_resource.record_type}, #{new_resource.record_name}).delete")
      response = get_zone.rrset(new_resource.record_type, new_resource.record_name).delete

      check_response(response, 'Failed to delete record.')
    end
  end
end

private

# Combine record_name and zone in the same format used by Neustar
def build_ownername(record_name, zone)
  str = record_name.end_with?('.') ? record_name + zone : record_name + '.' + zone
  zone.end_with?('.') ? str : str + '.'
end

def check_response(response, message = '')
  if response.code >= 400
    error = parsed_response.first rescue {}
    Chef::Log.error("#{message} #{error['errorCode']} : #{error['errorMessage']}")
    raise "#{message} #{error['errorCode']} : #{error['errorMessage']}"
  end
end

def client
  Chef::Log.debug("Ultradns::Client.new(#{new_resource.username}, #{new_resource.password}, #{new_resource.connection_options})")
  Ultradns::Client.new(new_resource.username, new_resource.password, new_resource.connection_options)
end

def get_zone
  if @zone.nil?
    @zone = client.zone(new_resource.zone)

    # query the zone metadata in order to verify that it exists
    response = @zone.metadata
    check_response(response, "Could not retrieve requested zone, #{new_resource.zone}")
  end

  @zone
end

def map_rdata(rdata)
  rdata.first
end

# rrtype when returned from Neustar will have some additional text included
# A (1) or CNAME (5)
def map_rrtype(rrtype)
  if rrtype.match /^A/i
    'A'
  elsif rrtype.match /^CNAME/i
    'CNAME'
  else
    Chef::Log.warn("Unrecognized rrType #{rrType}")
    rrtype
  end
end
