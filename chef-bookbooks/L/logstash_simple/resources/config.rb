property :input, String, default: ''
property :filter, String, default: ''
property :output, String, default: ''
property :name, String, default: ''
property :path, String, default: ''

action :create do

  filename = path + '/' +name
  
  template filename do
    source 'config_template.erb'
    mode '0644'
    cookbook 'logstash_simple'
    variables ({
      :input => input,
      :filter => filter,
      :output => output,
      :name => name
    })
  end

end