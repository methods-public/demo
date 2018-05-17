#
# Cookbook: securetty
#
# Copyright (c) 2016 Bloomberg L.P., All Rights Reserved.
#
securetty node['securetty']['path'] do 
 ttys node['securetty']['ttys']
end
