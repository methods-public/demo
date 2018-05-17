# providers/node.rb
#
# Copyright 2013, Simple Finance Technology Corp.
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

def zookeeper
  require 'kzookeeper'

  @zookeeper ||= begin
    ::Zookeeper.new(@new_resource.connect_str)
  end
end

action :create_if_missing do
  unless kzookeeper.stat(:path => @new_resource.path)[:stat].exists?
    kzookeeper.create(:path => @new_resource.path, :data => @new_resource.data)
  end
end

action :create do
  if kzookeeper.stat(:path => @new_resource.path)[:stat].exists?
    kzookeeper.set(:path => @new_resource.path, :data => @new_resource.data)
  else
    kzookeeper.create(:path => @new_resource.path, :data => @new_resource.data)
  end
end

action :delete do
  kzookeeper.delete(:path => @new_resource.path)
end
