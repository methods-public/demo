#
# cookbook::packer_fx
# recipe::kitchen
#
# author::fxinnovation
# description::Test recipe for kitchen
#

# Installing packer
packer_fx 'default' do
  version  '1.2.2'
  checksum '6575f8357a03ecad7997151234b1b9f09c7a5cf91c194b23a461ee279d68c6a8'
  action   :install
end
