require 'net/http'
require 'fileutils'
require 'yaml'
require 'securerandom'

class Chef
    class Provider
        class Conjurize < Chef::Provider::LWRPBase
            provides :conjurize

            def token_exchange appliance_url, host_identity, token
                uri = URI.parse("#{appliance_url}/host_factories/hosts?id=#{host_identity}")

                http = Net::HTTP.new(uri.host, uri.port)
                http.use_ssl = true
                http.verify_mode = OpenSSL::SSL::VERIFY_NONE

                request = Net::HTTP::Post.new(uri.request_uri)
                request['Authorization'] = "Token token=\"#{token}\""
                
                response = http.request(request)

                raise "Received #{response.code} from server when doing token exchange" if response.code.to_i != 201

                return JSON.parse(response.body)
            end

            def write_identity appliance_url, host_identity, host_factory_token, overwrite
                require 'netrc'

                Netrc.configure do |config|
                    # If this machine was previously conjurized with
                    # the conjur cookbooks, the permission may on this 
                    # file may be 0640 in order for the 'conjur' group
                    # to read it.
                    config[:allow_permissive_netrc_file] = true
                end

                conjur_identity = ::Netrc.read('/etc/conjur.identity')
                netrc_key = "#{appliance_url}/authn"

                existing_id, existing_api_key = conjur_identity[netrc_key]
                if not existing_id.nil?
                    # There's an identity that exists on disk that
                    # doesn't match what we're currently trying to
                    # provision the machine with. Only continue if
                    # we've set overwrite to true.
                    return if existing_id != host_identity and not overwrite
                end

                # We need an API key, do the token exchange.
                host = token_exchange(appliance_url, host_identity, host_factory_token)
                raise "Token exchange failed" if host.nil? or host['api_key'].nil?

                conjur_identity[netrc_key] = "host/#{host_identity}", host['api_key']
                conjur_identity.save
                ::FileUtils.chmod(0600, '/etc/conjur.identity')
            end


            action :run do
                chef_gem 'netrc'

                # Assign a UUID as the host name if nothing was provided
                if @new_resource.host_identity.nil? or @new_resource.host_identity.empty?
                    @new_resource.host_identity = SecureRandom.uuid
                end

                # Write conjur.identity if neccessary
                write_identity(@new_resource.appliance_url, 
                               @new_resource.host_identity, 
                               @new_resource.host_factory_token, 
                               @new_resource.overwrite)

                # Determine whether or not ssl_certificate contains the contents of a certificate
                # or a path to a pre-existing certificate on disk
                cert_is_path = ::File.exists?(@new_resource.ssl_certificate)
                cert_path = cert_is_path ? @new_resource.ssl_certificate : "/etc/conjur-#{@new_resource.account}.pem"

                # Write conjur.conf
                conjur_conf = {
                    'account' => @new_resource.account,
                    'appliance_url' => @new_resource.appliance_url,
                    'cert_file' => cert_path,
                    'netrc_path' => @new_resource.netrc_path
                }

                ::File.write('/etc/conjur.conf', conjur_conf.to_yaml)
                ::FileUtils.chmod(0644, '/etc/conjur.conf')

                # Write certificate if needed
                if not cert_is_path
                    ::File.write(cert_path, @new_resource.ssl_certificate)
                    ::FileUtils.chmod(0644, cert_path)
                end

                # If the machine is being Conjurized for SSH, then
                # we'll run the Conjur cookbooks to finish up.
                if @new_resource.ssh
                    include_recipe "conjur::default"
                end
            end
        end
    end
end