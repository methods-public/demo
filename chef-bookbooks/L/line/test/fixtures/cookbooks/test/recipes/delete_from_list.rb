cookbook_file '/tmp/dangerfile3' do
  owner 'root'
  mode '00644'
end

# Delete the first entry in a list with delimited entries
delete_from_list 'Delete Operation 1' do
  path '/tmp/dangerfile3'
  pattern 'my @net1918 ='
  delim [', ', '"']
  entry '10.0.0.0/8'
end

# # Delete the last entry in a list with delimited entries
delete_from_list 'Delete Operation 2' do
  path '/tmp/dangerfile3'
  pattern 'my @net1918 ='
  delim [', ', '"']
  entry '192.168.0.0/16'
end

delete_from_list 'Delete Operation 3' do
  path '/tmp/dangerfile3'
  pattern 'People to call:'
  delim [', ']
  entry 'Joe'
end

delete_from_list 'Delete Operation 4' do
  path '/tmp/dangerfile3'
  pattern 'People to call:'
  delim [', ']
  entry 'Karen'
end

delete_from_list 'Delete Operation 5' do
  path '/tmp/dangerfile3'
  pattern 'multi = '
  delim [', ', '[', ']']
  entry '425'
end

delete_from_list 'grub.conf - Remove rhgb' do
  path '/tmp/dangerfile3'
  pattern '^\\s*kernel .*'
  delim [' ']
  entry 'rhgb'
end

delete_from_list 'grub.conf - Remove quiet' do
  path '/tmp/dangerfile3'
  pattern '^\\s*kernel .*'
  delim [' ']
  entry 'quiet'
end

delete_from_list 'delimiter is 2 spaces' do
  path '/tmp/dangerfile3'
  pattern '^double  space'
  delim ['  ']
  entry 'separator'
end

delete_from_list 'delimiter is comma and space' do
  path '/tmp/dangerfile3'
  pattern '^list, comma-space'
  delim [', ']
  entry 'third'
end

delete_from_list 'delimiter is comma and space last entry' do
  path '/tmp/dangerfile3'
  pattern '^list, comma-space'
  delim [', ']
  entry 'fifth'
end

delete_from_list 'delimiter is space and comma' do
  path '/tmp/dangerfile3'
  pattern '^list ,space-comma'
  delim [' ,']
  entry 'third'
end

delete_from_list 'delimiter is space and comma last entry' do
  path '/tmp/dangerfile3'
  pattern '^list ,space-comma'
  delim [' ,']
  entry 'fifth'
end
