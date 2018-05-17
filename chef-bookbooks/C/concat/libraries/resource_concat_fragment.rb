class Chef
  class Resource
    # resource definition for the concat_fragment resource
    #
    # @author Edmund Rhudy <erhudy@gmail.com>
    class ConcatFragment < Chef::Resource::LWRPBase
      actions :create, :delete
      default_action :create

      resource_name :concat_fragment

      attribute :name, name_attribute: true,
                       kind_of: String,
                       required: true
      # order can be whatever you want (lexical sorting is used at the end
      # when compiling the fragments into the target)
      attribute :order, kind_of: [NilClass, String],
                        required: false,
                        default: nil
      attribute :target, kind_of: String,
                         required: true
      attribute :cookbook, kind_of: [NilClass, String],
                           required: false,
                           default: nil
      # :name will be used as :source if :source is not provided
      attribute :source, kind_of: [NilClass, String],
                         required: false,
                         default: nil
      # either Chef::Resource::Template or Chef::Resource:CookbookFile
      # (for Reasons this has to be enforced in the provider)
      attribute :source_provider, kind_of: Class,
                                  required: false,
                                  default: Chef::Resource::Template
      attribute :variables, kind_of: Hash,
                            required: false
    end
  end
end
