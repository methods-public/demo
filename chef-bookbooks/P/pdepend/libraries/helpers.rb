#
# Cookbook Name:: pdepend
# Library:: helpers
#
# Copyright (c) 2016, David Joos
#

# PDEPEND module
module PDEPEND
  # helpers module
  module Helpers
    # Returns an array of package names that will install pdepend on a node.
    # Package names returned are determined by the platform running this recipe.
    def pdepend_prerequisite_packages
      value_for_platform(
        'default' => ['libmagickwand-dev', 'libmagickcore-dev']
      )
    end
  end
end

# Chef class
class Chef
  # Recipe class
  class Recipe
    include PDEPEND::Helpers
  end
end
