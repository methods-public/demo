#
# Copyright (c) 2016-2017 Sam4Mobile, 2017-2018 Make.org
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

require 'yaml'

# Debugging cheatsheet
#
# List sessions:
# curl -s http://consul-swarm-centos-7:8500/v1/session/list | \
#   python -m json.tool
#
# Get all keys:
# curl -s http://consul-swarm-centos-7:8500/v1/kv/?recurse=true | \
#   python -m json.tool

module DockerPlatform
  # Consul Helper module
  module Consul
    def init_consul(consul_addr, consul_port, cluster_name)
      @cname = cluster_name
      require 'diplomat'
      Diplomat.configure do |config|
        config.url = "http://#{consul_addr}:#{consul_port}"
      end
    end

    def tam_registered?
      tam = tokens_and_managers
      !(tam.nil? || tam['managers'].nil? || tam['managers'].empty?)
    end

    def serialize_tam(tokens, managers)
      {
        'tokens' => tokens,
        'managers' => managers
      }.to_yaml
    end

    def tokens_key
      "swarm/#{@cname}/tokens_and_managers"
    end

    def initiator_key
      "swarm/#{@cname}/initiator"
    end

    def register_tokens_and_myself(tokens, myself)
      value = serialize_tam(tokens, [myself])
      Diplomat::Kv.put(tokens_key, value)
    rescue StandardError => e
      Chef::Log.error("Cannot write tokens in Consul:\n#{e}")
      raise e
    end

    def register(node)
      action = proc do |tam|
        serialize_tam(tam['tokens'], tam['managers'] << node)
      end
      write_cas_tam(action, 'register')
    end

    def unregister(node)
      action = proc do |tam|
        serialize_tam(tam['tokens'], tam['managers'] - [node])
      end
      write_cas_tam(action, 'unregister')
    end

    def write_cas_tam(action, source)
      tam = tokens_and_managers
      raise "Cannot #{source} #{manager}, cluster does not exist" if tam.nil?
      new = action.call(tam)
      Diplomat::Kv.put(tokens_key, new, cas: tam['modify_index'])
    rescue StandardError => e
      Chef::Log.error("Cannot register a manager in Consul:\n#{e}")
      raise e
    end

    # Called tam everywhere else
    def tokens_and_managers
      get_opts = { recurse: false, decode_values: true }
      raw = Diplomat::Kv.get(tokens_key, get_opts).first
      tam = YAML.safe_load(raw['Value'])
      tam['modify_index'] = raw['ModifyIndex']
      tam
    rescue Diplomat::KeyNotFound
      return {}
    rescue StandardError => e
      Chef::Log.error("Cannot get key '#{tokens_key}' from Consul:\n#{e}")
      raise e
    end

    def try_being_initiator(node)
      raise 'Error: already existing session_id' unless @session_id.nil?
      session_id = Diplomat::Session.create(Name: node, TTL: '60s')
      @session_id = session_id
      success = Diplomat::Lock.acquire(initiator_key, session_id)
      destroy_session unless success
      success
    end

    def release_initiator_lock
      raise 'No session_id to release initiator lock' if @session_id.nil?
      Diplomat::Lock.release(initiator_key, @session_id)
      destroy_session
    end

    def destroy_session
      Diplomat::Session.destroy(@session_id)
      @session_id = nil
    end
  end
end
