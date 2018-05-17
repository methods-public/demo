def whyrun_supported?
  true
end

use_inline_resources

action :scan do
  format = case new_resource.output
           when :normal
             'N'
           when :xml
             'X'
           when :script_kiddie
             'S'
           when :greppable
             'G'
           end
           
  cmd_str =  "nmap #{new_resource.options}"
  cmd_str << " -o#{format} '#{new_resource.filename}'"
  cmd_str << " #{new_resource.target}"
             
  execute cmd_str do
    Chef::Log.debug "nmap_scan: #{cmd_str}"
    Chef::Log.info  "Nmap Scanning: '#{new_resource.target}'"
  end
end
