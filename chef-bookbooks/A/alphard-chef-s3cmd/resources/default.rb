#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-s3cmd
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
resource_name :s3cmd

actions :nothing, :run
default_action :run

property :command, name_attribute: true, kind_of: [String, Array]
property :access_key, kind_of: [String, Array], default: nil
property :secret_key, kind_of: [String, Array], default: nil
property :callback, kind_of: Proc, default: proc { |_| }

action :run do
  # requires libraries
  require 'English'

  # defines variables
  resource = @new_resource
  command = resource.command ? resource.command : resource.name
  access_key_option = resource.access_key ? "--access_key=#{resource.access_key} " : ''
  secret_key_option = resource.secret_key ? "--secret_key=#{resource.secret_key} " : ''

  # includes s3cmd
  run_context.include_recipe('alphard-chef-s3cmd')

  # executes s3cmd
  begin
    system_command_options = "--no-mime-magic #{access_key_option}#{secret_key_option} "
    system_command = Mixlib::ShellOut.new(
      "s3cmd -c #{node['alphard']['s3cmd']['configuration_file']} #{system_command_options}#{command}"
    )
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
