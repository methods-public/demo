#
# cookbook::pam_radius
# recipe::kitchen
#
# author::fxinnovation
# description::Recipe used for kitchen tests
#

# Invoking pam radius resource
pam_radius 'default' do
  configuration node['pam_radius']['configuration']
  action        :install
end
