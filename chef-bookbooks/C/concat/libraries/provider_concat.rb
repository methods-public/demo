require_relative './helpers.rb'

class Chef
  class Provider
    # provider for the concat resource
    #
    # @author Edmund Rhudy <erhudy@gmail.com>
    class ConcatBase < Chef::Provider::LWRPBase
      use_inline_resources

      provides :concat

      include ConcatCookbook::Helpers

      # compile all the fragments in the directory (non-recursive) into a
      # single merged file, then pass that to the file platform resource to
      # update at the final destination
      action :create do
        dest_file = new_resource.path || new_resource.name

        source_path = get_staging_file_path(dest_file)

        dest_data = ''
        Dir.entries(source_path).sort.each do |f|
          full_path = ::File.join(source_path, f)
          dest_data << ::File.read(full_path) if ::File.file?(full_path)
        end

        target_file = Chef::Resource::File.new(dest_file, run_context)
        target_file.group(new_resource.group)
        target_file.owner(new_resource.owner)
        target_file.mode(new_resource.mode)
        target_file.content(dest_data)
        target_file.run_action(:create)

        new_resource.updated_by_last_action(target_file.updated_by_last_action?)
      end

      action :delete do
        dest_file = new_resource.path || new_resource.name
        updated = false
        # remove the target file
        if ::File.file?(dest_file)
          ::File.unlink(dest_file)
          updated = true
        end

        # remove the fragments directory
        fragment_dir = get_staging_file_path(dest_file)
        if ::File.directory?(fragment_dir)
          ::Dir.entries(fragment_dir).each do |f|
            full_path = ::File.join(fragment_dir, f)
            ::File.unlink(full_path) if ::File.file?(full_path)
            updated = true
          end
          ::Dir.unlink(fragment_dir)
        end

        new_resource.updated_by_last_action(updated)
      end
    end
  end
end
