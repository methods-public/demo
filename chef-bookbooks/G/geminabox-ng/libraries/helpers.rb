# frozen_string_literal: true
#
# Cookbook:: geminabox-ng
# Library:: helper
#
# The MIT License (MIT)
#
# Copyright:: 2017, QubitRenegade
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'pathname'

module GeminaboxNG
  # Helpers for geminabox-ng cookbook
  module Helpers
    def gib_username
      node['geminabox-ng']['user']['name']
    end

    def gib_homedir
      node['geminabox-ng']['user']['home_dir']
    end

    def gib_config_file
      File.join(
        gib_homedir,
        'config.ru'
      )
    end

    def unicorn_config_file
      File.join(
        gib_homedir,
        'geminabox.unicorn.app'
      )
    end

    def gib_data_dir
      node['geminabox-ng']['data_dir'] || File.join(
        gib_homedir,
        'data'
      )
    end

    def gib_rack_env
      node['geminabox-ng']['unicorn']['rack_env'] || 'production'
    end

    def unicorn_path
      File.join(
        gib_homedir,
        '.rbenv/shims/unicorn'
      )
    end

    def unicorn_host
      node['geminabox-ng']['unicorn']['host'] || '127.0.0.1'
    end

    def unicorn_port
      node['geminabox-ng']['unicorn']['port'] || '8080'
    end

    def unicorn_socket
      if node['geminabox-ng']['unicorn']['socket']['dir']
        File.join(
          node['geminabox-ng']['unicorn']['socket']['dir'],
          node['geminabox-ng']['unicorn']['socket']['file_name']
        )
      else
        File.join gib_homedir, node['geminabox-ng']['unicorn']['socket']
      end
    end
    # rubocop:enable Metrics/AbcSize

    def unicorn_http_addr
      "#{unicorn_host}:#{unicorn_port}"
    end

    def unicorn_listen
      if node['geminabox-ng']['unicorn']['socket']
        unicorn_socket
      else
        unicorn_http_addr
      end
    end
  end
end

Chef::Recipe.send(:include, GeminaboxNG::Helpers)
Chef::Mixin::Template.send(:include, GeminaboxNG::Helpers)
Chef::Mixin::Template::TemplateContext.send(:include, GeminaboxNG::Helpers)
Chef::Resource::Directory.send(:include, GeminaboxNG::Helpers)
