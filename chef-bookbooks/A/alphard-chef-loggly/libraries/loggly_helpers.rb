#
# Cookbook Name:: alphard-chef-loggly
# Library:: loggly_helpers
#
# Copyright (C) 2017 Hydra Technologies
# Copyright (C) 2016 Daniel Searles
# Copyright (C) 2014 Matt Veitas
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

# loggly helpers
module LogglyHelpers
  def configure_files(original_files)
    # The .to_h is required because files aren't hashes, but are chef node
    # attributes, which are supposed to be treated as immutable, unless we
    # actually want to override the value (which here, we don't.)
    valid_files(original_files).map(&:to_h).map do |file|
      file['tag'] ||= File.basename(file['filename']).tr('.', '-')
      file['statefile'] ||= "#{file['filename']}.rsyslog_state"
      file
    end
  end

  private def valid_files(original_files)
    original_files.reject do |file|
      !file.is_a?(Hash) || file['filename'].to_s.strip.empty?
    end
  end

  def loggly_format(app_name)
    app_name_initial_caps = app_name.to_s.gsub(/\b(?<!['â`])[a-z]/, &:capitalize)
    "LogglyFormat#{app_name_initial_caps}"
  end

  def tags
    (node['loggly']['tags'] || []).map { |tag| "tag=\\\"#{tag}\\\"" }.join(' ')
  end

  def app_conf(app_name)
    "#{node['loggly']['rsyslog']['conf_dir']}/21-#{app_name}.conf"
  end

  def assign_default_rsyslog_version
    node.default['loggly']['rsyslog_major_version'] = version_for_platform || 7
  end

  private def version_for_platform
    versions = versions_by_platform_name[node['platform']]
    highest_match = versions.keys.detect do |key|
      node['platform_version'].to_f >= key
    end
    highest_match && versions[highest_match]
  end

  private def versions_by_platform_name
    # The Hash.new with default value ensures we'll be able to chain
    # Enumerable methods when there's no platform match.
    Hash.new({}).merge(node['loggly']['rsyslog_versions_by_platform'])
  end

  def supports_statefile?
    node['loggly']['rsyslog_major_version'] < 8
  end

  def supports_function_syntax?
    node['loggly']['rsyslog_major_version'] >= 7
  end
end
