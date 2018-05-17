#
# Cookbook Name:: YumUtils
# Library:: RepoUtils
#
# Copyright 2013-2017, whitestar
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

module YumUtils
  # Repository utilities methods
  module RepoUtils
    def create_mirror_user(name, home_dir)
      resources(group: name) rescue group name do
        system true
        action :create
      end

      resources(user: name) rescue user name do
        gid name
        system true
        home home_dir
        shell '/bin/sh'
        password nil
        action :create
      end
    end

    def create_mirror_dirs(mirror_user, base_path)
      [
        '',
        'mirror',
        'var',
      ].each {|subdir|
        directory "#{base_path}/#{subdir}" do
          owner mirror_user
          group mirror_user
          mode '0755'
          recursive true
        end
      }
    end

    def parse_repo_files(repos_dir)
      repos = {}
      current_repo = nil
      current_prop = nil

      Dir.chdir(repos_dir)
      Dir.glob('*.repo') {|repo_file_name|
        open(repo_file_name) {|repo_file|
          repo_file.each {|line|
            line.strip!
            next if line.start_with?('#')
            next if line.empty?

            if /^\[(.*)\]$/ =~ line
              repo_id = Regexp.last_match(1)
              current_repo = {}
              repos[repo_id] = current_repo
            else
              prop = line.split('=')
              if prop.size == 1  # for multi line values.
                current_repo[current_prop] = current_repo[current_prop] + ',' + prop[0].strip
              else
                current_prop = prop[0].strip
                current_repo[prop[0].strip] = prop[1].strip
              end
            end
          }
        }
      }

      repos
    end

    def install_reposync
      %w(
        yum-utils
        createrepo
      ).each {|pkg|
        resources(package: pkg) rescue package pkg do
          action :install
        end
      }
    end

    def reposync_base_setup(
      mirror_user,
      base_path,
      yum_conf_path,
      repos_dir,
      repo_ids,
      arch,
      url_alias_with_authority_part = true)

      install_reposync
      create_mirror_user(mirror_user, base_path)
      create_mirror_dirs(mirror_user, base_path)

      repos = parse_repo_files(repos_dir)

      reposync_sources = []
      url_aliases = {}
      repo_ids.each {|repo_id|
        unless repos.key?(repo_id)
          Chef::Log.warn("Yum repository definition (id: #{repo_id}) not found!")
          next
        end

        repo = repos[repo_id]
        ctx_path = repo['baseurl'].gsub(%r{^http://}, '')
        gpgkey_ctx_path = repo['gpgkey'].gsub(%r{^http://}, '')

        local_path = "#{base_path}/mirror/#{ctx_path}"
        local_path.end_with?('/') && local_path.chop!
        local_parent_path = File.dirname(local_path)
        actual_repo_path = "#{local_parent_path}/#{repo_id}"
        local_gpgkey_path = "#{base_path}/mirror/#{gpgkey_ctx_path}"

        [
          local_parent_path,
          actual_repo_path,
          File.dirname(local_gpgkey_path),
        ].each {|dir|
          resources(directory: dir) rescue directory dir do
            owner mirror_user
            group mirror_user
            mode '0755'
            recursive true
          end
        }

        link local_path do
          to actual_repo_path
        end

        resources(remote_file: local_gpgkey_path) rescue remote_file local_gpgkey_path do
          source repo['gpgkey']
          owner mirror_user
          group mirror_user
          mode '0644'
        end

        src = {
          'id' => repo_id,
          'local_path' => local_path,
          'reposync_command' => "reposync -c #{yum_conf_path} -a #{arch} -r #{repo_id} -p #{local_parent_path}",
          'createrepo_command' => "createrepo #{local_path}",
        }
        reposync_sources.push(src)

        ctx_path_elms = ctx_path.split('/')
        gpgkey_ctx_path_elms = gpgkey_ctx_path.split('/')
        if url_alias_with_authority_part
          url_aliases["/#{ctx_path_elms[0]}"] \
            = "#{base_path}/mirror/#{ctx_path_elms[0]}"
          url_aliases["/#{gpgkey_ctx_path_elms[0]}"] \
            = "#{base_path}/mirror/#{gpgkey_ctx_path_elms[0]}"
        else
          url_aliases["/#{ctx_path_elms[1]}"] \
            = "#{base_path}/mirror/#{ctx_path_elms[0]}/#{ctx_path_elms[1]}"
          url_aliases["/#{gpgkey_ctx_path_elms[1]}"] \
            = "#{base_path}/mirror/#{gpgkey_ctx_path_elms[0]}/#{gpgkey_ctx_path_elms[1]}"
        end
      }

      [reposync_sources, url_aliases]
    end
  end
end
