#
# Copyright (c) 2017 Sam4Mobile, 2017-2018 Make.org
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

# We need seeds nodes before attempting any config
run_state = node.run_state[cookbook_name]
return if run_state.nil? || run_state['seeds'].nil?

# Create config directories
directory node[cookbook_name]['config_dir'] do
  user node[cookbook_name]['user']
  group node[cookbook_name]['user']
  mode '0755'
  recursive true
end

# Deploy cassandra configuration files
# First, install needed gems
package_retries = node[cookbook_name]['package_retries']
chef_gem 'xml-simple' do
  compile_time true
  retries package_retries unless package_retries.nil?
end
::Chef::Recipe.send(:require, 'xmlsimple')
::Chef::Recipe.send(:require, 'net/http') # Used to download default files

# Simplified deep merge, should be librarytized with the rest of this file
merge_proc = proc do |_, old, new|
  old.respond_to?(:merge) ? old.merge(new, &merge_proc) : new
end

# Deploy cassandra configuration files
# rubocop:disable Metrics/BlockLength # I know :)
node[cookbook_name]['config'].to_hash.each do |filename, config|
  # Set seed_provider in cassandra.yaml from search results
  if filename == 'cassandra.yaml'
    config['seed_provider'] = [{
      'class_name' => 'org.apache.cassandra.locator.SimpleSeedProvider',
      'parameters' => [{ 'seeds' => run_state['seeds'].join(',') }]
    }]
  end

  # To make default attributes simpler, we download default from git
  # to merge them with user attributes
  git = node[cookbook_name]['git']
  version = node[cookbook_name]['version']
  rfile = "#{git};a=blob_plain;f=conf/#{filename};hb=cassandra-#{version}"

  # Do we download the default file from git?
  download =
    node[cookbook_name]['download_default']
    .to_hash.keep_if { |_, v| v }.keys
    .map { |regex| filename.match?(regex) }.any?
  default_str = download ? ::Net::HTTP.get(URI(rfile)) : ''

  content = # Select method based on extension
    case filename.split('.').last
    when 'properties'
      config =
        default_str
        .lines
        .reject { |l| l.start_with?('#') || !l.include?('=') }
        .map { |l| l.chomp.split('=') }.to_h
        .merge(config)
      config.map { |k, v| "#{k}=#{v}" }.join("\n")
    when 'yaml'
      ::YAML.safe_load(default_str).merge(config, &merge_proc).to_yaml
    when 'xml'
      config = ::XmlSimple.xml_in(default_str).merge(config, &merge_proc)
      ::XmlSimple.xml_out(config, 'RootName' => 'configuration')
    when 'options'
      config =
        default_str
        .lines.keep_if { |l| l.start_with?('-') }
        .map { |l| [l.chomp, l.chomp] }.to_h
        .merge(config)
      config.values.reject(&:empty?).join("\n")
    else # No merge possible here, we just use values and remove empty ones
      config.values.reject(&:empty?).join("\n")
    end

  file "#{node[cookbook_name]['config_dir']}/#{filename}" do
    content "#{content}#{"\n" if content[-1] != "\n"}"
    owner node[cookbook_name]['user']
    group node[cookbook_name]['group']
    mode '0644'
  end
  # rubocop:enable Metrics/BlockLength # I know :)
end
