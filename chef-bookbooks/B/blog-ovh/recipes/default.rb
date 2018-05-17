#
# Cookbook:: blog-ovh
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'vim'
package 'zsh'

bash 'Install oh-my-zsh' do
  user 'root'
  cwd '/root'
  code <<-EOH
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  EOH
  not_if{ ::File.exist?('/root/.oh-my-zsh')}  
end

unless node['blog']['hostname'].nil?
    hostname = node['blog']['hostname']

    bash 'Set Hostname' do
      user 'root'
      cwd '/tmp'
      code <<-EOH
        hostname #{hostname}
      EOH
    end

    file '/etc/hostname' do
      action :create
      content hostname
    end

end

