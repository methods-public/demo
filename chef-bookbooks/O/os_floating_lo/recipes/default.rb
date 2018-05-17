#
# Cookbook Name:: os_floating_lo
# Recipe:: default
#
# Copyright (C) 2016 John Bartko
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# https://gist.github.com/scalp42/7606857
resource_exists = proc do |name|
  begin
    resources name
    true
  rescue Chef::Exceptions::ResourceNotFound
    false
  end
end

# catch properly hinted nodes w/o ohai in resolved cookbooks
ohai_hint 'openstack' if node.attribute?('openstack')

# add IP to interface at compile time, reload Ohai for remaining run_list
if resource_exists['ohai_hint[openstack]']
  ifconfig node['openstack']['public_ipv4'] do
    device node['os_floating_lo']['device']
    mask node['os_floating_lo']['mask']
  end.run_action(:add)
  ohai 'network/interfaces' do
    action :reload
  end
else
  Chef::Log.warn <<-EOT.prepend("#{cookbook_name}::#{recipe_name}\n").chomp
    No Ohai openstack hints! Cannot assign floating IP to #{node['os_floating_lo']['device']}}
    issue \"echo -n '{}' | sudo tee #{node['ohai']['hints_path']}/openstack.json\"
    - OR -
    add \"ohai_hint 'openstack'\" to a recipe in the node's run_list
  EOT
end
