module ChefJenkins
  module Helper
    def partial_template(name, type, options, cookbook, include_templates)
      template_name = "_#{type}_#{name}.xml.erb"
      cookbook_name = include_templates.include?(template_name) ? cookbook : 'chef_jenkins'
      if options.empty?
        render "_#{type}_#{name}.xml.erb", cookbook: cookbook_name
      else
        case options.class
        when 'Chef::Node::ImmutableMash'
          render "_#{type}_#{name}.xml.erb", variables: { name => options.to_h }, cookbook: cookbook_name
        when 'Chef::Node::ImmutableArray'
          render "_#{type}_#{name}.xml.erb", variables: { name => options.to_a }, cookbook: cookbook_name
        else
          render "_#{type}_#{name}.xml.erb", variables: { name => options }, cookbook: cookbook_name
        end
      end
    end
  end
end
