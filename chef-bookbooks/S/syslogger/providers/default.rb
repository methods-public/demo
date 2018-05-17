def whyrun_supported?
  true
end

use_inline_resources

action :write do
  cmd_str =  "echo '#{new_resource.message}' | logger"
  cmd_str << " -t '#{new_resource.tag}' " if new_resource.tag
  cmd_str << " -p '#{new_resource.facility}.#{new_resource.level}' "
  cmd_str << new_resource.options if new_resource.options

  execute cmd_str do
    Chef::Log.debug "syslogger_write: #{cmd_str}"
    Chef::Log.info  "SysLogging: '#{new_resource.message}'"
  end
end
