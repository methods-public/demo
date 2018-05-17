#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-deploy
# Definition:: deep_template
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
define :deep_template, directory: nil, template_directory: nil, user: nil, group: nil, variables: nil do
  directory = params[:directory]
  template_directory = params[:template_directory]
  user = params[:user]
  group = params[:group]
  variables = params[:variables]

  ruby_block params[:name] do
    block do
      # Defines the deep template method
      def deep_template(directory, template_directory, user, group, variables)
        Dir.entries(template_directory).each do |template_name|
          template_file = "#{template_directory}/#{template_name}"
          if File.file?(template_file)
            if template_name.end_with?('.erb')
              # template file do
              #   source template_file
              #   owner user
              #   group group
              #   mode '0644'
              #   local true
              #   variables variables
              #   action :create
              # end
              file = "#{directory}/#{template_name.chomp('.erb')}"
              t = Chef::Resource::Template.new(file, run_context)
              t.source(template_file)
              t.owner(user)
              t.group(group)
              t.mode('0644')
              t.local(true)
              t.variables(variables)
              t.action(:create)
              t.run_action('create')
            else
              # file file do
              #   owner user
              #   group group
              #   backup false
              #   content File.open(template_file, 'r').read
              #   mode '0644'
              #   action :create
              # end
              file = "#{directory}/#{template_name}"
              f = Chef::Resource::File.new(file, run_context)
              f.owner(user)
              f.group(group)
              f.backup(false)
              f.content(File.open(template_file, 'r').read)
              f.mode('0644')
              f.action(:create)
              f.run_action('create')
            end
          elsif File.directory?(template_file) && template_name != '..' && template_name != '.'
            subdirectory = "#{directory}/#{template_name}"
            # directory configuration_subdirectory do
            #   owner user
            #   group group
            #   mode '0755'
            #   action :create
            # end
            d = Chef::Resource::Directory.new(subdirectory, run_context)
            d.owner(user)
            d.group(group)
            d.mode('0755')
            d.action(:create)
            d.run_action('create')
            deep_template(subdirectory, template_file, user, group, variables)
          end
        end
      end

      # Calls the recursive method
      deep_template(directory, template_directory, user, group, variables)
    end
  end
end
