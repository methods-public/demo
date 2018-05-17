require 'mixlib/shellout'
require 'net/http'
require 'net/https'

def extracting_gzip(file_location, extract_to)
  return unless new_resource.extract

  directory extract_to

  cmd = "tar xzf #{file_location} -C #{extract_to}"
  cmd += ' --strip-components=1' if new_resource.strip

  execute cmd do
    # A directory will always have the '.' and '..' entries. If we extracted files,
    # there will be more.
    not_if { Dir.entries(extract_to).count > 2 }
  end
end

def get(file_location, url)
  remote_file file_location do
    source url
  end
end

def symlinking(source, destination)
  return unless new_resource.symlink

  link destination do
    to source
  end
end

def validate_url(url)
  raise 'Invalid file/URL. Aborting.' unless url =~ /(http|https)/
end
