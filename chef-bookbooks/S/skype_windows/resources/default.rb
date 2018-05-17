actions :install 

if node['kernel']['machine'] == 'x86_64' 
attribute :install_directory, :kind_of => [String], default: '"C:\Program Files (x86)\skype "'
else
attribute :install_directory, :kind_of => [String], default: '"C:\Program Files\skype "'
end
attribute :all_users, :kind_of => [String], default: '0'


