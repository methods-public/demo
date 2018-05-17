unless defined?(GoogleStackdriver::Helper)
  module GoogleStackdriver
    module Helper
      include Chef::Mixin::ShellOut

      def convert_to_gcm(content)
        content.gsub!(%r{/etc/sysconfig/stackdriver}, '/etc/sysconfig/gcm-stackdriver')
        content.gsub!(%r{/etc/default/stackdriver-agent}, '/etc/default/gcm-stackdriver-agent')
        content.gsub!(/stackdriver-extractor/, 'gcm-stackdriver-extractor')
        content.gsub!(%r{/etc/init.d/stackdriver-agent}, '/etc/init.d/gcm-stackdriver-agent')
        content.gsub!(%r{/opt/stackdriver/collectd/sbin/stackdriver-collectd}, '/opt/stackdriver/collectd/sbin/gcm-stackdriver-collectd')
        content.gsub!(%r{/opt/stackdriver/collectd/etc/collectd.conf}, '/opt/stackdriver/collectd/etc/gcm-collectd.conf')
        content.gsub!(%r{/var/run/stackdriver-agent.pid}, '/var/run/gcm-stackdriver-agent.pid')
        content.gsub!(/prog="stackdriver-collectd"/, 'prog="gcm-stackdriver-collectd"')
        content.gsub(/NAME=stackdriver-agent/, 'NAME=gcm-stackdriver-agent')
      end

      def google_credentials_from_file?
        node['google_stackdriver']['service_account']['file_provided']
      end

      def google_credentials_from_vars?
        %w[client_email client_id client_x509_cert_url private_key private_key_id project_id x509_cert_url].all? do |credential|
          node['google_stackdriver']['service_account'][credential]
        end
      end

      def google_stackdriver?
        google_credentials_from_file? || google_credentials_from_vars?
      end

      def stackdriver_legacy?
        node['google_stackdriver']['api_key'].is_a? String
      end
    end
  end
end
