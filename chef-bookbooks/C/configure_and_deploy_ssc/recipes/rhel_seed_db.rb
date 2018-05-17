#
# Cookbook Name:: configure_and_deploy_ssc
# Recipe:: rhel_seed_db
#

# This recipe will seed the SSC database with the SRG content.
# The decidion to actually seed a given seed-bundle is controlled in the attributes.
# Below is the basic command line usage used to manually seed a seed-bundle to the SSC DB.
# java -jar ssc-configuration-wizard.jar -automationMode -war ssc.war -bundle ..\HP_Fortify_<bundlename>_Seed_Bundle_<year>_<quarter>.zip

# Seeds the PCI seed bundle
bash "Seed PCI" do
  user "root"
  action :run
  code <<-EOH
     java -jar "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['war_configurator_dir']}/ssc-configuration-wizard.jar" \
     -automationMode \
     -war "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['war_configurator_dir']}/ssc.war" \
     -bundle "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['pci_bundle_name']}"
  EOH
  only_if { node['seed_pci_bundle'] == true }
  ignore_failure true
end

# Seeds the report seed bundle
bash "Seed Reports" do
  user "root"
  action :run
  code <<-EOH
     java -jar "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['war_configurator_dir']}/ssc-configuration-wizard.jar" \
     -automationMode \
     -war "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['war_configurator_dir']}/ssc.war" \
     -bundle "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['reports_bundle_name']}"
  EOH
  only_if { node['seed_reports_bundle'] == true }
  ignore_failure true
end

# Seeds the process seed bundle
bash "Seed Process" do
  user "root"
  action :run
  code <<-EOH
     java -jar "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['war_configurator_dir']}/ssc-configuration-wizard.jar" \
     -automationMode \
     -war "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['war_configurator_dir']}/ssc.war" \
     -bundle "#{node['configure_ssc']['working_dir']}#{node['configure_ssc']['process_bundle_name']}"
  EOH
  only_if { node['seed_process_bundle'] == true }
  ignore_failure true
end
