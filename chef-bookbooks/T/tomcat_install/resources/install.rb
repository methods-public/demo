resource_name :alternatives

default_action :run

property :extraction_command, String
def extraction_command 
cmd = "alternatives --install /usr/bin/java java /opt/jdk1.8.0_121/bin/java 2000 && alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_121/bin/jar 2000 && alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_121/bin/javac 2000 && alternatives --install /usr/bin/javaws javaws /opt/jdk1.8.0_121/bin/javaws 2000 && alternatives --set java /opt/jdk1.8.0_121/bin/java && alternatives --set jar /opt/jdk1.8.0_121/bin/jar && alternatives --set javac /opt/jdk1.8.0_121/bin/javac && alternatives --set javaws /opt/jdk1.8.0_121/bin/javaws"
end

action :run do
execute 'extract java tarball' do
   command extraction_command
   end
end
