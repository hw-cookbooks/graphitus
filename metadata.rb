name             'graphitus'
maintainer       "Heavy Water Operations, LLC"
maintainer_email "support@hw-ops.com"
license          'Apache 2.0'
description      'Manages Graphitus, a simple graphite based dashboard system.'
version          '0.0.1'

%w(ubuntu centos).each do |os|
  supports os
end

depends 'git'
