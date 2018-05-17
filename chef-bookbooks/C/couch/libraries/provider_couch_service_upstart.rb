require_relative 'provider_couch_service'

class Chef
  class Provider
    class CouchService
      class Upstart < Chef::Provider::CouchService
        action :start do
          template 'couch_upstart_conf' do
            path '/etc/init/couchdb.conf'
            action :create
            owner 'root'
            group 'root'
            cookbook 'couch'
            source 'couch.upstart.erb'
            variables(couchdb_wd: ::File.join(new_resource.path_prefix, 'bin'))
          end

          service 'couchdb' do
            provider Chef::Provider::Service::Upstart
            action [:enable, :start]
          end
        end

        action :stop do
          service 'couchdb' do
            provider Chef::Provider::Service::Upstart
            action [:disable, :stop]
          end
        end

        action :restart do
          service 'couchdb' do
            provider Chef::Provider::Service::Upstart
            action :restart
          end
        end
      end
    end
  end
end
