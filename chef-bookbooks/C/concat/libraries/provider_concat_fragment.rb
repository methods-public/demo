require 'digest'
require 'fileutils'
require 'pathname'
require_relative './helpers.rb'

class Chef
  class Provider
    # provider for the concat_fragment resource
    #
    # @author Edmund Rhudy <erhudy@gmail.com>
    class ConcatFragmentBase < Chef::Provider::LWRPBase
      use_inline_resources

      provides :concat_fragment

      include ConcatCookbook::Helpers

      action :create do
        source = new_resource.source || new_resource.name
        cookbook = new_resource.cookbook || cookbook_name

        # create a template resource with the information from this resource,
        # but write the template out to a staging location in the Chef cache

        staging_path = get_staging_file_path(new_resource.target)
        staging_file = get_staging_file_name(source,
                                             new_resource.target,
                                             new_resource.order)
        FileUtils.mkdir_p(staging_path)

        unless new_resource.source_provider == Chef::Resource::Template || \
               new_resource.source_provider == Chef::Resource::CookbookFile
          fail ':source_provider must be either ' \
               'Chef::Resource::Template or ' \
               'Chef::Resource::CookbookFile'
        end

        fragment = new_resource.source_provider.new(staging_file, run_context)
        fragment.source(source)
        fragment.cookbook(cookbook.to_s)
        fragment.owner('root')
        fragment.mode(00600)
        if fragment.class == Chef::Resource::Template
          fragment.variables(new_resource.variables)
        end
        fragment.run_action(:create)

        new_resource.updated_by_last_action(fragment.updated_by_last_action?)
      end

      action :delete do
        source = new_resource.source || new_resource.name
        staging_file = get_staging_file_name(source,
                                             new_resource.target,
                                             new_resource.order)
        if ::File.file?(staging_file)
          ::File.unlink(staging_file)
          new_resource.updated_by_last_action(true)
        else
          new_resource.updated_by_last_action(false)
        end
      end
    end
  end
end
