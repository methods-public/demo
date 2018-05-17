resource_name :dotnet

property :instance_name, String, name_property: true
property :path, String, required: false, default: '.'
property :packages_path, kind_of: String, required: false 
property :nuget_config_file, kind_of: String, required: false
property :source, kind_of: String, required: false
property :disable_parallel, kind_of: [TrueClass, FalseClass], default: false
property :no_cache, kind_of: [TrueClass, FalseClass], default: false
property :verbosity, kind_of: String, required: false, default: 'Information' 
property :configuration, String, required: false, default: 'Debug'
property :restore, kind_of: [TrueClass, FalseClass], default: true
property :args, Array, required: false, default: []

# Useful properties from the `execute` resource
property :cwd, kind_of: String
property :environment, kind_of: Hash, default: {}
property :user, kind_of: [String, Integer]
property :sensitive, kind_of: [TrueClass, FalseClass], default: false

default_action :run

action :restore do

    disable_parallel = new_resource.disable_parallel ? '--disable-parallel' : ''
    source = !new_resource.source.nil? ? "--source #{new_resource.source}" : ''
    no_cache = new_resource.disable_parallel ? '--no-cache' : ''
    packages = !new_resource.packages_path.nil? ? "--packages #{new_resource.packages_path}" : ''
    configfile = !new_resource.nuget_config_file.nil? ? "--configfile #{new_resource.nuget_config_file}" : ''

    execute 'dotnet-restore' do
        cwd new_resource.cwd
        environment new_resource.environment
        user new_resource.user
        sensitive new_resource.sensitive
        command "dotnet restore --verbosity #{new_resource.verbosity} #{source} #{packages} #{configfile} #{no_cache} #{disable_parallel}"
    end
end

action :run do

    # Restore dependent nuget packages before running by default.
    dotnet 'dotnet-restore-run' do
        action :restore
        nuget_config_file new_resource.nuget_config_file
        disable_parallel new_resource.disable_parallel
        source new_resource.source
        no_cache new_resource.no_cache
        packages_path new_resource.packages_path
        user new_resource.user
        cwd new_resource.cwd
        only_if { new_resource.restore }
    end

    execute 'dotnet-run' do
        cwd new_resource.cwd
        environment new_resource.environment
        user new_resource.user
        sensitive new_resource.sensitive
        command "dotnet run -c #{new_resource.configuration} -p #{new_resource.path} #{new_resource.args.join(" ")}"
    end
end