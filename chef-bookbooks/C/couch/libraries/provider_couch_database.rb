require_relative 'api_helpers'

class Chef
  class Provider
    class CouchDatabase < Chef::Provider::CouchBase
      include Couch::APIHelpers

      def load_current_resource
        @current_resource ||= Chef::Resource::CouchDatabase.new(new_resource.name)
        @current_resource
      end

      action :create do
        if exist?
          new_resource.updated_by_last_action false
        else
          resp = couchdb_put(new_resource.database, host, options)
          if resp.is_a? Net::HTTPCreated
            new_resource.updated_by_last_action true
          else
            fail "Unexpected response code #{resp.code} while creating database #{new_resource.database}"
          end
        end
      end

      action :delete do
        if exist?
          resp = couchdb_delete(new_resource.database, host, options)
          if resp.is_a? Net::HTTPOK
            Chef::Log.debug('recieved a 200 from the couchdb server')
            new_resource.updated_by_last_action true
          else
            fail "Unexpected response code #{resp.code} while deleting database #{new_resource.database}"
          end
        else
          new_resource.updated_by_last_action false
        end
      end

      def exist?
        resp = couchdb_get('_all_dbs', host, options)
        if resp.is_a? Net::HTTPOK
          Chef::Log.debug('recieved a 200 from couchdb server')
          result = JSON.parse(resp.body)

          if result.include? new_resource.database
            return true
          else
            return false
          end
        else
          fail "Unexpected response code #{resp.code} while querying #{resp.uri}"
        end
      end
    end
  end
end
