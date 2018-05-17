#
# Cookbook Name:: dcos-grid
# Library:: Helper
#
# Copyright 2016, whitestar
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

module DCOSGrid
  # Helper methods
  module Helper
    CONFIG_PARAMS = %w(
      agent_list
      bootstrap_url
      cluster_name
      ip_detect_filename
      exhibitor_storage_backend
      exhibitor_zk_hosts
      exhibitor_zk_path
      aws_access_key_id
      aws_region
      aws_secret_access_key
      exhibitor_explicit_keys
      s3_bucket
      s3_prefix
      exhibitor_azure_account_name
      exhibitor_azure_account_key
      exhibitor_azure_prefix
      exhibitor_fs_config_dir
      master_discovery
      master_list
      exhibitor_address
      num_masters
      rexray_config_method
      rexray_config_filename
      public_agent_list
      dns_search
      master_dns_bindall
      resolvers
      use_proxy
      http_proxy
      https_proxy
      no_proxy
      check_time
      docker_remove_delay
      gc_delay
      log_directory
      process_timeout
      auth_cookie_secure_flag
      customer_key
      ssh_key_path
      ssh_port
      ssh_user
      superuser_password_hash
      superuser_username
      telemetry_enabled
      oauth_auth_host
      oauth_auth_redirector
      oauth_available
      oauth_enabled
      oauth_issuer_url
      oauth_client_id
      dcos_overlay_enable
      dcos_overlay_config_attempts
      dcos_overlay_mtu
      dcos_overlay_network
      vtep_subnet
      vtep_mac_oui
      overlays
      name
      subnet
      prefix
    ).freeze

    def sanitize_config(config)
      config = Marshal.load(Marshal.dump(config))
      validate_config_keys(config)
      config
    end

    def validate_config_keys(config_node)
      if config_node.is_a?(Hash)
        config_node.each {|key, value|
          unless CONFIG_PARAMS.include?(key)
            Chef::Log.warn("invalid config key: #{key}")
            # Chef attribute container is immutable.
            #config_node.delete(key)
            next
          end

          validate_config_keys(value)
        }
      elsif config_node.is_a?(Array)
        config_node.each {|elm|
          validate_config_keys(elm)
        }
      end
    end
  end
end
