#
# Cookbook Name:: paintdotnet
# Recipe:: default
#
# Copyright (C) 2014 Sean Fleming
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

if node['platform_family'] == 'windows'
	
	
	if not File.exists?('C:/Program Files/paint.net/PaintDotNet.exe')

		# Cache zip file and unzip it locally.
		unpackDir = node['paintdotnet']['unzipdir']
		unpackedInstaller = "#{unpackDir}/#{node['paintdotnet']['filename']}.exe"
		
		windows_zipfile unpackDir do
	  		source node['paintdotnet']['downloadurl']
	  		action :unzip
	  		not_if {::File.exists?(unpackedInstaller)}
		end

		#TODO Call exe with /createMsi parameter and then call the x86 or x64 
		#       version depending on the system.
		# 	  Except... the msis are created on the desktop, and this shows a UI
		#      which means I'd have to bundle the MSI with the cookbook. Yuk!

		#     Current implementation shows a progress UI.

		windows_package node['paintdotnet']['package_name'] do
	  		source unpackedInstaller
	  		checksum node['paintdotnet']['checksum']
	  		options '/auto'
	  		action :install
		end
	end
end