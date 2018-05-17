class Chef
  class Resource
    # resource definition for the concat resource
    #
    # @author Edmund Rhudy <erhudy@gmail.com>
    class Concat < Chef::Resource::LWRPBase
      actions :create, :delete
      default_action :create

      resource_name :concat

      attribute :name, name_attribute: true,
                       kind_of: String,
                       required: true
      # :name will be used as :path if :path is not provided
      attribute :path, kind_of: [NilClass, String],
                       required: false,
                       default: nil
      attribute :owner, kind_of: [String, Integer],
                        required: false,
                        default: 'root'
      attribute :group, kind_of: [String, Integer],
                        required: false,
                        default: 'root'
      attribute :mode, kind_of: [String, Integer],
                       required: false,
                       default: 00755
    end
  end
end
