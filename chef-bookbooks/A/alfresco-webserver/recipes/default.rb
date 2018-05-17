# Default recipe is always nginx

include_recipe "alfresco-webserver::#{node['webserver']['engine']}"
