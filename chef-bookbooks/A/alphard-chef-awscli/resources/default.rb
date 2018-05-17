#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-awscli
# Resource:: default
#
# Copyright:: 2017, Hydra Technologies, Inc
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
resource_name :awscli

actions :nothing, :run
default_action :run

property :command, name_attribute: true, kind_of: [String, Array]
property :callback, kind_of: Proc, default: proc { |_| }

action :run do
  # requires libraries
  require 'English'

  # defines variables
  resource = @new_resource
  command = resource.command ? resource.command : resource.name

  # includes awscli
  run_context.include_recipe('alphard-chef-awscli')

  # configures awscli
  ENV['AWS_CONFIG_FILE'] = node['alphard']['awscli']['configuration_file']

  # executes awscli
  begin
    system_command = Mixlib::ShellOut.new("aws #{command} 2>&1".strip)
    output = nil
    converge_by("execute command: #{system_command}\n") do
      system_command.run_command
      system_command.error!
      output = system_command.stdout
    end
    exit_code = $CHILD_STATUS.exitstatus
    raise output if exit_code > 0
    Chef::Log.debug "command result:\n#{output}"
    resource.callback.call(output)
  rescue StandardError => e
    raise e unless resource.ignore_failure
    Chef::Log.warn e.message
  end
end
