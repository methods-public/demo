module AWSToolsAndSDKForNetSdk
	module Helper
		
		def is_aws_installed?()
			registry_key_exists?(node['AWS_ms_dotnet']['package_regkey'])
		end

		def is_aws_version_installed?()
			if (!is_aws_installed?())
				return false
			end

			registry_data_exists?(node['AWS_ms_dotnet']['package_regkey'],
			{ :name => "#{node['AWS_ms_dotnet']['package_regkey_name']}", :type => :string, :data => "#{node['AWS_ms_dotnet']['package_regkey_version']}"}
			)
		end
	end
end