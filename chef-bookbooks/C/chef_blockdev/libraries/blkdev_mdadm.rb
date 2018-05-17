# -*- coding: utf-8 -*-
include Chef::Mixin::ShellOut

require 'shellwords'
require 'mixlib/shellout'

class Chef
  class Resource
    # blkdev mdadm resource
    class BlkdevMdadm < Chef::Resource
      identity_attr :name

      # rubocop:disable MethodLength
      def initialize(name, run_context = nil)
        super
        @resource_name = :blkdev_mdadm
        @provider = Chef::Provider::BlkdevMdadm
        @action = :create
        @allowed_actions = [:create, :assemble, :build, :manage, :misc, :grow, :incremental]
        @name = name
        @options = nil
        @source = nil
      end

      def options(arg = nil)
        set_or_return(:options, arg, kind_of: [Array, Hash, Mash])
      end

      def source(arg = nil)
        set_or_return(:source, arg, kind_of: [Array, String])
      end

      def name(arg = nil)
        set_or_return(:name, arg, kind_of: [String])
      end

    end
  end
end

class Chef
  class Provider
    # blkdev mdadm provider
    class BlkdevMdadm < Chef::Provider

      def whyrun_supported?
        true
      end

      def load_current_resource
        @current_resource = Chef::Resource::BlkdevMdadm.new(@new_resource.name)
        @current_resource.name(@new_resource.name)
        @current_resource.options(@new_resource.options)
        @current_resource.source(@new_resource.source)
        @current_resource
      end

      def exist?(name)
        Mixlib::ShellOut.new("mdadm --query #{name}", environment: { 'LC_ALL' => nil }).run_command.exitstatus == 0
      end

      def active?(name)
        Mixlib::ShellOut.new("mdadm --detail #{name} | grep -qE 'State : active|State : clean'", environment: { 'LC_ALL' => nil }).run_command.exitstatus == 0
      end

      def options_string
        return options.map{|k,v|
          if v.nil?
            if k.length > 1
              "--#{k}"
            else
              "-#{k}"
            end
          else
            if k.length > 1
              "--#{k}=#{v}"
            else
              "-#{k} #{v}"
            end
          end
        }
      end

      def sources_string
        case source
        when String
          return source
        when Array
          return source.join(' ')
        end
      end

      def action_create
        execute "mdadm --create #{name} #{options_string} #{sources_string}" do
          command "mdadm --create #{name} #{options_string} #{sources_string}"
          not_if { exist?(name) }
        end
        new_resource.updated_by_last_action(true)
      end

      def action_assemble
        execute "mdadm --assemble #{name} #{options_string}" do
          command "mdadm --assemble #{name} #{options_string}"
          not_if { exist?(name) }
        end
        new_resource.updated_by_last_action(true)
      end

    end
  end
end

