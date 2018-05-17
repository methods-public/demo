name             "annoyances"
maintainer       "Matt Ray"
maintainer_email "matt@getchef.com"
license          "Apache 2.0"
description      "Removes assorted operating system annoyances."
version          "1.0.0"

%w{ debian fedora redhat ubuntu }.each do |os|
  supports os
end
