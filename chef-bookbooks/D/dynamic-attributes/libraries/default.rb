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
  def rec_forest(hash, paths, evaluator)
    [paths].flatten.each do |s_path|
      path = s_path.split('/').reject(&:empty?)
      sub = path[0...-1].reduce(hash) do |a, e|
        # We use fetch instead of [] because hash is a VividMash
        a.is_a?(Hash) ? a.fetch(e, nil) : nil
      end
      unless sub.nil?
        value = path.last.nil? ? sub : sub.fetch(path.last, nil)
        rec(sub, value, evaluator, path)
      end
    end
  end

  def rec(hash, value, evaluator, backtrack)
    if value.is_a? String
      rec_string(hash, value, evaluator, backtrack)
    elsif value.is_a? Hash
      rec_hash(value, evaluator, backtrack)
    elsif value.is_a? Array
      rec_array(hash, value, evaluator, backtrack)
    end
  end

  def rec_hash(hash, evaluator, backtrack)
    modified_keys = []
    hash.each do |key, value|
      rec(hash, value, evaluator, Array.new(backtrack) << key)
      newkey = evaluator.call key
      modified_keys << [key, newkey] if key != newkey
    end
    modified_keys.each { |key, newkey| hash[newkey] = hash.delete key }
    node.reset backtrack.first unless modified_keys.empty?
  end

  def rec_array(hash, value, evaluator, backtrack)
    acc = value.each_with_index.each_with_object({}) do |(val, i), h|
      h[i] = val
    end
    rec_hash(acc, evaluator, Array.new(backtrack))
    newvalue = acc.values
    write(hash, value, newvalue, backtrack)
  end

  def rec_string(hash, value, evaluator, backtrack)
    newvalue = evaluator.call value
    write(hash, value, newvalue, backtrack)
  end

  def write(hash, value, newvalue, backtrack)
    return if value == newvalue
    hash[backtrack.last] = newvalue unless newvalue.nil?
    node.reset backtrack.first
  end
end
