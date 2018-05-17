require_relative 'provider_couch_service'

class Chef
  class Provider
    class CouchService
      class Systemd < Chef::Provider::CouchService
        action :start do
          template 'couch_systemd_conf' do
            path '/lib/systemd/system/couchdb.service'
            action :create
            owner 'root'
            group 'root'
            mode 0644
            cookbook 'couch'
            source 'couch.systemd.erb'
            variables(path_prefix: new_resource.path_prefix)
          end

          service 'couchdb' do
            provider Chef::Provider::Service::Systemd
            action [:enable, :start]
          end
        end

        action :stop do
          service 'couchdb' do
            provider Chef::Provider::Service::Systemd
            action [:disable, :stop]
          end
        end

        action :restart do
          service 'couchdb' do
            provider Chef::Provider::Service::Systemd
            action :restart
          end
        end
      end
    end
  end
end
