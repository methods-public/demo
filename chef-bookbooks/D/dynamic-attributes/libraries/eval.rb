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
  module Eval
    include DynamicAttributes
    def eval_attributes(attributes_kind, whitelist)
      evaluator = lambda do |value|
        eval "\"#{prepare(value)}\"" # rubocop:disable Lint/Eval
      end
      rec_forest(node.send(attributes_kind), whitelist, evaluator)
    end

    # Escape " to avoid any conflict with surrounding ones we add
    def prepare(value)
      value.to_s.gsub('"', '\"')
    end
  end
end
