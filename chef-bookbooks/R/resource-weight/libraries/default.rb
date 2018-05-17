require 'chef/resource'

class Chef
  class Resource
    property(:weight, Numeric,
             cannot_be:     :negative,
             default:       0,
             desired_state: false,)
  end
end
