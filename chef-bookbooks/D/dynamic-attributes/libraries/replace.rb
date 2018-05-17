#
# Copyright (c) 2016 Sam4Mobile, 2017 Make.org
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

# Module to be mixined with recipe to be used
module DynamicAttributes
  # Sub-module to be able to select exactly what we want
  module Replace
    include DynamicAttributes
    def replace_attributes(attributes_kind, whitelist)
      attributes = node.send(attributes_kind)
      rec_forest(attributes, whitelist, ->(v) { replace_value(v) })
    end

    def replace_value(value)
      visited = Set.new
      while replaceable? value
        raise 'Infinite loop detected' if visited.include?(value)
        visited << value
        value = fetch_value value
      end
      value
    end

    def replaceable?(value)
      value.is_a?(String) && /\Anode(\[('[^']+'|:[\w]+)\])+\Z/ =~ value
    end

    def fetch_value(node_path)
      path = node_path.scan(/\[(?:'([^']+)'|:([\w]+))\]/).flatten.compact
      path.reduce(node.attributes) { |a, e| a[e] }
    end
  end
end
