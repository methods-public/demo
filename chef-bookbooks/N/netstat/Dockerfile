FROM zuazo/chef-local:debian-7

COPY . /tmp/netstat
RUN berks vendor -b /tmp/netstat/Berksfile $COOKBOOK_PATH
RUN chef-client -r "recipe[apt],recipe[netstat]"

CMD ["netstat", "-nptua"]
