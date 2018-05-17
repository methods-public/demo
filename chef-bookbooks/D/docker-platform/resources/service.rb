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

property :bin, kind_of: String, default: '/bin/docker'
property :service, kind_of: String, name_property: true
property :detach, kind_of: [TrueClass, FalseClass], default: true
property :image, kind_of: String, default: ''
property :command, kind_of: String, default: ''

# Options and arg are hashes like: { 'option_name' => 'option_value' }
# Option names are assumed to begin by '--' so you must use complete names
# Note: all occurences of character '_' are replaced by '-'
property :options, kind_of: Hash, default: {}

action :create do
  unless already_created?(new_resource.service)
    raise 'Swarm: please set an image for service creation' if image.empty?
    converge_by("Create swarm #{new_resource.service} service") do
      create_service(new_resource.service, new_resource.detach)
    end
  end
end

def create_service(name, detach)
  shell_out!(
    <<-BASH
      #{bin} service create #{detach ? '--detach' : ''} --name #{name} \
        #{str_options} #{image} #{command}
    BASH
  )
end

def str_options
  options.map do |key, opt|
    [opt].flatten.map do |single_opt|
      "--#{key.to_s.tr('_', '-')} #{single_opt}".chomp(' ')
    end
  end.flatten.join(' ')
end

def already_created?(name)
  shell_out(
    <<-BASH
      #{bin} service ls \
      --filter name=#{name} --format '{{.Name}}' | grep '^#{name}$'
    BASH
  ).exitstatus.zero?
end
