require_relative 'provider_couch_service'

class Chef
  class Provider
    class CouchService
      class Sysvinit < Chef::Provider::CouchService
        action :start do
          template 'couch_sysvinit_conf' do
            path '/etc/init.d/couchdb'
            action :create
            owner 'root'
            group 'root'
            mode 0755
            cookbook 'couch'
            source 'couch.init.erb'
            variables(path_prefix: new_resource.path_prefix)
          end

          service 'couchdb' do
            action [:enable, :start]
          end
        end

        action :stop do
          service 'couchdb' do
            action [:disable, :stop]
          end
        end

        action :restart do
          service 'couchdb' do
            action :restart
          end
        end
      end
    end
  end
end
