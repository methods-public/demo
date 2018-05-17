source "https://supermarket.chef.io"

metadata

cookbook 'ohai'

group :integration do
  cookbook 'export_node', path: 'test/fixtures/cookbooks/export_node'
  cookbook 'os_floating_lo_tester', path: 'test/fixtures/cookbooks/os_floating_lo_tester'
end
