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

property :cluster_name, kind_of: String, name_property: true
property :role, kind_of: String, default: 'manager'
property :consul_addr, kind_of: String, required: true
property :consul_port, kind_of: Integer, default: 8500
property :bin, kind_of: String, default: '/bin/docker'

# Options is a hash like: { 'option_name' => 'option_value' }
# Option names are assumed to begin by '--' so you must use complete names
# Note: all occurences of character '_' are replaced by '-'
property :join_opts, kind_of: Hash, default: {}
property :init_opts, kind_of: Hash, default: {}

# Consul lib
action_class do
  include DockerPlatform::Consul
end

action :join do
  nr = new_resource
  init_consul(nr.consul_addr, nr.consul_port, nr.cluster_name)
  return if joined?
  tam = tokens_and_managers
  raise 'Swarm: could not join cluster, token unavailable' if tam.nil?
  converge_by "join swarm cluster: #{nr.cluster_name}" do
    catch(:done) do
      tam['managers'].each do |manager|
        join_opts = nr.join_opts
        throw :done if join_swarm(manager, tam['tokens'][nr.role], join_opts)
      end
      raise "Swarm: could not join cluster, bad managers or bad tokens: #{tam}"
    end
  end
end

action :init do
  nr = new_resource
  return unless nr.role == 'manager'
  init_consul(nr.consul_addr, nr.consul_port, nr.cluster_name)
  return if tam_registered?
  error = 'Swarm: could not initialize cluster, initiator already exists'
  raise error unless try_being_initiator(node['fqdn'])
  converge_by "init swarm cluster: #{nr.cluster_name}" do
    init_swarm(join_opts.merge(new_resource.init_opts)) unless joined?
    register_tokens_and_myself(swarm_tokens, node['fqdn'])
    release_initiator_lock
  end
end

action :unregister do
  nr = new_resource
  init_consul(nr.consul_addr, nr.consul_port, nr.cluster_name)
  tam = tokens_and_managers
  return unless to_unregister?(tam['managers'])
  converge_by "unregister as manager in swarm #{nr.cluster_name}" do
    raise 'Swarm: failed to unregister myself' unless unregister(node['fqdn'])
  end
end

action :register do
  nr = new_resource
  init_consul(nr.consul_addr, nr.consul_port, nr.cluster_name)
  tam = tokens_and_managers
  return unless to_register?(tam['managers'])
  converge_by "register as manager in swarm #{nr.cluster_name}" do
    raise 'Swarm: failed to register myself' unless register(node['fqdn'])
  end
end

# Swarm helpers

def joined?
  !shell_out("#{bin} info | grep 'Swarm: inactive'").exitstatus.zero?
end

def swarm_role
  if shell_out("#{bin} info | grep 'Is Manager: true'").exitstatus.zero?
    'manager'
  else
    'worker'
  end
end

def to_unregister?(list)
  (list || []).include?(node['fqdn']) && (!joined? || swarm_role != 'manager')
end

def to_register?(list)
  joined? && swarm_role == 'manager' && !list.include?(node['fqdn'])
end

def init_swarm(options)
  shell_out!("#{bin} swarm init #{str(options)}")
end

def join_swarm(manager, token, options)
  Chef::Log.info("trying to join with #{manager}")
  shell_out("#{bin} swarm join #{str(options)} #{manager} --token #{token}")
    .exitstatus.zero?
end

def swarm_tokens
  {
    'manager' => shell_out!("#{bin} swarm join-token -q manager").stdout.chomp,
    'worker' => shell_out!("#{bin} swarm join-token -q worker").stdout.chomp
  }
end

def str(options)
  options.map { |key, opt| "--#{key.to_s.tr('_', '-')} #{opt}" }.join(' ')
end
