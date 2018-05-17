#
# Cookbook:: nant
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright:: 2017, Fabrício Corrêa Duarte
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

uncompressed = File.join(node['nant']['home'], "nant-#{node['nant']['version']}")
uncompressed_bin = File.join(uncompressed, 'bin')
bin_folder = File.join(node['nant']['home'], 'bin')

windows_zipfile node['nant']['home'] do
  source "https://downloads.sourceforge.net/project/nant/nant/#{node['nant']['version']}/nant-#{node['nant']['version']}-bin.zip"
  action :unzip
  not_if { File.exist? uncompressed }
end

link bin_folder do
  to uncompressed_bin
end

windows_path bin_folder do
  action :add
end
