require_relative 'api_helpers'

class Chef
  class Provider
    class CouchQuery < Chef::Provider::CouchBase
      include Couch::APIHelpers

      def load_current_resource
        @current_resource ||= Chef::Resource::CouchQuery.new(new_resource.name)
        @current_resource
      end

      action :put do
        options['body'] = new_resource.body unless new_resource.body.empty?
        resp = couchdb_put(new_resource.urn, host, options)

        Chef::Log.debug("Couchdb Response body: #{resp.body}")
        unless resp.code == expected_response(201)
          fail "Unexpected response code #{resp.code} while executing put #{new_resource.urn} with body #{new_resource.body}"
        end
        new_resource.updated_by_last_action true
      end

      action :post do
        options[:body] = new_resource.body unless new_resource.body.empty?
        resp = couchdb_post(new_resource.urn, host, options)

        Chef::Log.debug("Couchdb Response body: #{resp.body}")
        unless resp.code == expected_response(201)
          fail "Unexpected response code #{resp.code} while executing post #{new_resource.urn} with body #{new_resource.body}"
        end
        new_resource.updated_by_last_action true
      end

      action :get do
        options[:body] = new_resource.body unless new_resource.body.empty?
        resp = couchdb_get(new_resource.urn, host, options)

        Chef::Log.debug("Couchdb Response body: #{resp.body}")
        unless resp.code == expected_response(200)
          fail "Unexpected response code #{resp.code} while executing get #{new_resource.urn} with body #{new_resource.body}"
        end
        new_resource.updated_by_last_action true
      end

      action :delete do
        options[:body] = new_resource.body unless new_resource.body.empty?
        resp = couchdb_delete(new_resource.delete, host, options)

        Chef::Log.debug("Couchdb Response body: #{resp.body}")
        unless resp.code == expected_response(201)
          fail "Unexpected response code #{resp.code} while executing delete #{new_resource.urn} with body #{new_resource.body}"
        end
        new_resource.updated_by_last_action true
      end

      def expected_response(resp_code)
        new_resource.response_code || resp_code
      end
    end
  end
end
