# => Notes
# 1. Only one instance of a runtime-name can be enabled at any given time...
# 2. If the runtime name does not end in .war, it will not deploy properly (register web context)


  def api_client
    @api_client ||= WildFly::ApiClient.new
  end

  def runtime_exists?
    resp = read_deployments.find { |d| d['runtime-name'] == new_resource.runtime_name }
    return false unless resp
  end

  def deploy_exists?(deploy)
    read_deployments.any? { |d| d['name'] == deploy }
  end

  def deploy_enabled?(deploy)
    read_deployments.any? { |d| d['name'] == deploy && d['enabled'] }
  end

  def deploy_redeploy(deploy)
    api_client.do('redeploy', ['deployment', deploy])
  end

  def deploy_enable(deploy)
    api_client.do('deploy', ['deployment', deploy])
  end

  def deploy_disable(deploy)
    api_client.do('undeploy', ['deployment', deploy])
  end

  def deploy_remove(deploy)
    api_client.do('remove', ['deployment', deploy])
  end

  def runtime_disable(runtime)
    deploy = read_deployments.find { |d| d['runtime-name'] == runtime && d['enabled'] }
    return unless deploy
    deploy = deploy['name']
    api_client.do('undeploy', ['deployment', deploy])
  end

  def read_runtime(runtime)
    read_deployments.select { |d| d['runtime-name'] == runtime }
  end

  def runtime_cleanup(runtime)
    remove = read_runtime(runtime).select { |x| !x['enabled'] }
    remove.each do |x|
      deploy_remove(x['name'])
    end
  end

  def runtime_cleanupp(runtime)
    read_runtime(runtime).sort_by { |x| x['disabled-time'] }.reverse.first
  end

  def runtime_remove(runtime)
    deploy = read_deployments.find { |d| d['runtime-name'] == runtime }
    return unless deploy
    deploy = deploy['name']
    api_client.do('remove', ['deployment', deploy])
    deploy_remove(deploy)
  end

  # => Pass this a Deployment Object
  def deploy_checksum(deploy)
    bin = Base64.decode64(deploy['content'].first['hash']['BYTES_VALUE'])
    bin.each_byte.map { |b| b.to_s(16) }.join
  end

  def read_runtime(runtime)
    read_deployments.select { |d| d['runtime-name'] == runtime }
  end

  def read_deployment(deploy)
    dpl = api_client.do('read-resource', ['deployment', deploy])
    return dpl['result'] if dpl['outcome'] == 'success'
    dpl
  end

  def read_deployments
    r = api_client.do('read-resource', ['deployment', '*'])
    return [] unless r['result']
    r['result'].map { |x| x['result'] }.compact
  end

  # => CRAP

  def deploy_install(deploy, parameters, runtime = nil)
    path = [
      'deployment',
      deploy
    ]
    deploy = {
      'content' => [parameters],
      'runtime-name' => runtime,
      'enabled' => false
    }
    api_client.do('add', path, deploy)
  end

  def deploy_dummy(deploy = 'dummy', runtime = 'dummy.war')
    params = {}
    params['url'] = 'https://github.com/efsavage/hello-world-war/raw/master/dist/hello-world.war'
    deploy_install(deploy, params, runtime)
  end

  # => Create a bunch of Dummys
  def deploy_lots_of_dummys(number = 10)
    (1..number.to_i).each { |x| deploy_dummy(x) }
  end

  def deploy_lots_of_dummys_enable(number = 10)
    (1..number.to_i).each do |x|
      deploy_dummy(x)
      deploy_enable(x)
      deploy_disable(x)
    end
  end

def get_old(deploy = 'dummy.war', keep = 5)
  # => Find Old Deployments
  candidates = read_runtime('dummy.war').select { |d| !d['enabled'] && d['disabled-time'] }
  # => Keep the First 'keep' deploys
  to_delete = candidates.sort_by { |x| x['disabled-time'] }.reverse.drop(keep)
  to_delete.each do |d|
    deploy_remove(d['name'])
  end
end


sort_by { |x| x['disabled-time'] }.reverse

read_runtime('dummy.war').select { |d| !d['enabled'] }.sort_by { |x| x['disabled-time'] || true }.reverse.first

read_runtime('dummy.war').sort_by { |x| x['disabled-time'] || true }.reverse.first

def fib(n)
  return n if n <= 1
  return fib(n-1) + fib(n-2)
end

docker network create -d bridge \
  --opt com.docker.network.bridge.enable_icc=true \
  dokken



# => Ruby SSL Debugging

require 'socket'
require 'openssl'
# https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz
ssl_context = OpenSSL::SSL::SSLContext.new
cert_store = OpenSSL::X509::Store.new
cert_store.set_default_paths
ssl_context.cert_store = cert_store
ssl_context.verify_mode = OpenSSL::SSL::VERIFY_PEER
tcp_client = TCPSocket.new 'dev.mysql.com', 443
ssl_client = OpenSSL::SSL::SSLSocket.new tcp_client, ssl_context
ssl_client.connect

curl --cacert cacert.pem --cert-status https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz
