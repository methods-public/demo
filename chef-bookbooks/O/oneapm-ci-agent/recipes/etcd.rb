include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor etcd
#
# LICENSE endpoint of your etcd instance
# - url: "https://server:port"
#   Change the time to wait on an etcd LICENSE request
#   timeout: 5
#
#   If certificate-based authentication of clients is enabled on your etcd server,
#   specify the key file and the certificate file that the check should use.
#   ssl_keyfile: /path/to/key/file
#   ssl_certfile: /path/to/certificate/file
#
#   Set to `false` to disable the validation of the server's SSL certificates (default: true).
#   ssl_cert_validation: true
#
#   If ssl_cert_validation is enabled, you can provide a custom file
#   that lists trusted CA certificates (optional).
#   ssl_ca_certs: /path/to/CA/certificate/file

oneapm_ci_agent_monitor 'etcd' do
  instances node['oneapm-ci-agent']['etcd']['instances']
end
