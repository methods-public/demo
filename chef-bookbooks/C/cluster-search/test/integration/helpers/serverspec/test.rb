#
# Copyright (c) 2015-2016 Sam4Mobile, 2017-2018 Make.org
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

require 'spec_helper'

test_list = []

File.open('/tmp/test_list', 'r') do |f|
  f.each_line do |line|
    test_list << line.chomp.split('#')
  end
end

i = 0
test_list.each do |test, result|
  i += 1
  describe "Test case: #{test}" do
    describe file("/tmp/testcase_#{format('%02d', i)}") do
      its(:content) { should eq result.to_s }
    end
  end
end
