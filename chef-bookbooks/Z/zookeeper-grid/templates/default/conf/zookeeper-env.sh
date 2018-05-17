export JAVA_HOME=<%= node['java']['java_home'] %>

export ZOO_LOG_DIR=<%= node['zookeeper']['ZOO_LOG_DIR_PREFIX'] %><%= @node_id == '' ? '' : "/#{@node_id}"%>

<%
this_file = 'zookeeper-env.sh'
if defined? node['zookeeper']['extra_configs'][this_file] \
  && node['zookeeper']['extra_configs'][this_file] != nil then
  node['zookeeper']['extra_configs'][this_file].each do |key, value|
%>
export <%= key %>=<%= value %>
<%
  end
end
%>
