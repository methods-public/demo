module ConcatCookbook
  # helper methods used elsewhere in the cookbook
  #
  # @author Edmund Rhudy <erhudy@gmail.com>
  module Helpers
    def munge_filename_for_staging(file)
      file.tr("#{::File::SEPARATOR}.", '_')
    end

    def get_staging_file_path(target)
      ::File.join(
        Chef::Config[:file_cache_path],
        'concat_staging',
        munge_filename_for_staging(target))
    end

    def get_staging_file_name(source, target, order)
      staging_path = get_staging_file_path(target)
      staging_filename = order ? "#{order}_#{source}" : source
      ::File.join(staging_path, staging_filename)
    end
  end
end
