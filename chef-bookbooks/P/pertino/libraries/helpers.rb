module PertinoCookbook
  # Helpers to perform more complex actions in Provider
  #
  # @see Chef::Provider::PertinoClient
  # @since 0.1.0
  # @author Mike Fiedler <miketheman@gmail.com>
  module Helpers
    include Chef::DSL::IncludeRecipe

    # Perform package repository setup based on platform
    #
    def configure_package_repositories
      case node['platform_family']
      when 'debian'
        setup_debian_repo
      when 'rhel'
        setup_redhat_repo
      else
        Chef::Log.info('Unsupported platform, here be dragons.')
      end
    end

    # Perform Device Authentication using Network API Key
    #
    # @param api_key [String] Network API Key, in GUID format.
    # @example '27c0206e-15aa-46b0-842e-3f216f11d8a5'
    def perform_device_auth(api_key)
      execute '.pauth' do
        command "/opt/pertino/pgateway/.pauth --apikey=#{api_key}"
        not_if "grep -q #{api_key} /opt/pertino/pgateway/conf/client.conf"
        notifies :restart, 'service[pgateway]'
      end
    end

    # Perform User/Pass Authentication
    #
    # @param username [String] full email address used for Pertino login
    # @param password [String] the secret half of the equation
    def perform_user_auth(username, password)
      fail 'You must provide both username and password!' unless username && password
      execute '.pauth' do
        command "/opt/pertino/pgateway/.pauth --username=#{username} --password=#{password}"
        not_if "grep -q #{username} /opt/pertino/pgateway/conf/client.conf"
        notifies :restart, 'service[pgateway]'
        ignore_failure allow_auth_failures?
      end
    end

    # Allow the auth command to fail in test environments where we use bogus creds
    # @return [TrueClass] if determined inside a test environment
    # @return [FalseClass] default value
    def allow_auth_failures?
      return true if node.key?('virtualization') && node['virtualization']['system'] == 'vbox'
      return true if ::File.exist?('/.dockerenv')
      return true if ENV['CI']
      false
    end

    private

    def setup_debian_repo
      apt_repository 'pertino' do
        uri 'http://reposerver.pertino.com/debs'
        # FIXME: Currently repo only has an entry for 'precise'
        # Use `node['lsb']['codename']` when the repo supports it.
        distribution 'precise'
        components ['multiverse']
        # Prefer keyserver over remote url, since keysoerver & fingerprint
        # prevent triggering an outbount HTTPS call each run.
        # @example alternate method:
        #   key 'http://reposerver.pertino.com/Pertino-GPG-Key.pub'
        keyserver 'keyserver.ubuntu.com'
        key '326BD77B'
      end
    end

    def setup_redhat_repo
      yum_repository 'pertino' do
        description 'Pertino VPN Client'
        baseurl 'http://reposerver.pertino.com/rpms'
        gpgcheck true
        gpgkey 'http://reposerver.pertino.com/Pertino-GPG-Key.pub'
        sslverify true
        enabled true
      end
    end
  end
end
