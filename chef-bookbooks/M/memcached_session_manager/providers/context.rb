def whyrun_supported?
  true
end

action :install do
  converge_by('memcached_session_manager_context install') do
    recipe_eval do
      run_context.include_recipe 'memcached_session_manager::default'
    end

    context_manager_path = "#{Chef::Config[:file_cache_path]}/context_manager.xml"

    template context_manager_path do
      source 'context_manager.xml.erb'
      cookbook 'memcached_session_manager'
      variables(resource: new_resource)
    end

    ruby_block 'install manager' do
      block do
        context = ::IO.read(new_resource.path)
        manager = ::IO.read(context_manager_path)
        if (context =~ %r{<Manager.*/>}m).nil? # install manager
          context = context.gsub(%r{</Context>}, "#{manager}</Context>")
        else # update manager
          context = context.gsub(%r{<Manager.*/>}m, manager)
        end
        ::File.open(new_resource.path, 'w') { |file| file.puts context }
      end
    end
  end
end

action :remove do
  converge_by('memcached_session_manager_context remove') do
    ruby_block 'remove manager' do
      block do
        context = ::IO.read(new_resource.path)
        unless (context =~ %r{<Manager.*/>}m).nil?
          context = context.gsub(%r{<Manager.*/>}m, '')
          ::File.open(new_resource.path, 'w') { |file| file.puts context }
        end
      end
    end
  end
end
