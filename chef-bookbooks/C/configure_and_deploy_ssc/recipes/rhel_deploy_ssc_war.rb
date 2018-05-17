#
# Cookbook Name:: configure_and_deploy_ssc
# Recipe:: rhel_deploy_ssc_war
#
# This recipe will deploy the ssc.war file.  Make sure that rhel_workspace_setup, 
# rhel_create_db, rhel_configure_war, and rhel_seed_db have ran prior to running 
# this recipe.

#Change ownership of the war file so that tomcat can deploy it properly
#Deploy the war file.
ruby_block 'deploy_war' do
  block do
    if !File.file?("#{node['tomcat']['install_dir']}/webapps/ssc.war")
      FileUtils.chown("#{node['tomcat']['service_user']}", "#{node['tomcat']['service_group']}", "#{node['configure_ssc']['working_dir']}HPE-Security-Fortify-Server-WAR/ssc.war")
      FileUtils.cp("#{node['configure_ssc']['working_dir']}HPE-Security-Fortify-Server-WAR/ssc.war", "#{node['tomcat']['install_dir']}/webapps/", :preserve => true)
    end
  end
end
