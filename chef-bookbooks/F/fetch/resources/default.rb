require_relative '../libraries/helpers'

resource_name :fetch

property :archive_type, String, default: 'gzip'
property :download_to, String, default: Chef::Config[:file_cache_path]
property :extract, default: true
property :extract_to, String
property :file, String, name_property: true
property :strip, default: true
property :symlink, default: false
property :symlink_to, String

def whyrun_supported?
  true
end

action :fetch do
  validate_url(new_resource.file)

  file_name = new_resource.file.split('/').last
  file_location = "#{new_resource.download_to}/#{new_resource.file.split('/').last}"

  get(file_location, new_resource.file)

  case new_resource.archive_type
  when 'gzip'
    extracting_gzip(file_location, new_resource.extract_to)
    symlinking(new_resource.extract_to, new_resource.symlink_to)
  end
end
