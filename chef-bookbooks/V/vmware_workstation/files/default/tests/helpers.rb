module Helpers
  # Helper methods for minitests
  module MinitestHandler
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
  end
end
