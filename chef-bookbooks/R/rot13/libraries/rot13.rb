#
# Cookbook Name:: rot13
# Library:: rot13
#
# Copyright 2014, Fletcher Nichol
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

module Rot13
  def self.encode(string)
    return nil if string.nil?

    string.each_char.map { |ch|
      case ch
      when /^[a-z]$/
        (((ch.ord - "a".ord + 13) % 26) + "a".ord).chr
      when /^[A-Z]$/
        (((ch.ord - "A".ord + 13) % 26) + "A".ord).chr
      else
        ch
      end
    }.join
  end
end
