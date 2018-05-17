#
# cookbook::pam_fx
# recipe::kitchen
#
# author::fxinnovation
# description::Recipe for kitchen tests, do not use in production
#

pam_fx node['pam_fx']['name'] do
  lines node['pam_fx']['lines']
end
