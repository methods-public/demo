%w(xtra ignore).each do |file|
  template "/etc/cxs/#{file}" do
    source 'template_semic.erb'
    mode '0600'
    variables params: node['cxs'][file]
  end 
end
