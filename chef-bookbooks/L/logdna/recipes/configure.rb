# Configure LogDNA Agent

conf_key = node['logdna']['conf_key']
conf_config = node['logdna']['conf_config']
conf_logdir = node['logdna']['conf_logdir']
conf_logfile = node['logdna']['conf_logfile']
conf_exclude = node['logdna']['conf_exclude']
conf_hostname = node['logdna']['conf_hostname']
conf_tags = node['logdna']['conf_tags']
conf_exclude_regex = node['logdna']['conf_exclude_regex']

if !conf_config.nil?

  ## Using alternate configuration file:
  begin
    execute 'update config' do
      command 'logdna-agent -c ' + conf_config
      action :run
    end
  rescue
    raise 'Please, install logdna-agent...'
  end

else

  ## Adding LogDNA Ingestion Key into /etc/logdna.conf
  unless conf_key.nil?
    begin
      execute 'update key' do
        command 'logdna-agent -k ' + conf_key
        action :run
      end
    ## It is enough to check here
    ## whether agent has been installed:
    rescue
      raise 'Please, install logdna-agent...'
    end
  end

  ## Adding directories to watch into /etc/logdna.conf
  ## if exists:
  unless conf_logdir.nil?
    execute 'update directories' do
      command 'logdna-agent -d ' + conf_logdir
      action :run
    end
  end

  ## Including files to watch into /etc/logdna.conf
  ## if exists:
  unless conf_logfile.nil?
    execute 'include files' do
      command 'logdna-agent -f ' + conf_logfile
      action :run
    end
  end

  ## Excluding files from watching in /etc/logdna.conf
  ## if exists:
  unless conf_exclude.nil?
    execute 'exclude files' do
      command 'logdna-agent -d ' + conf_exclude
      action :run
    end
  end

  ## Using alternate hostname in /etc/logdna.conf
  ## if exists:
  unless conf_hostname.nil?
    execute 'update hostname' do
      command 'logdna-agent -n ' + conf_hostname
      action :run
    end
  end

  ## Adding tags into /etc/logdna.conf
  ## if exists:
  unless conf_tags.nil?
    execute 'add tags' do
      command 'logdna-agent -t ' + conf_tags
      action :run
    end
  end

  ## Excluding files having the regular expression in names,
  ## if exists:
  unless conf_exclude_regex.nil?
    execute 'exclude regex' do
      command 'logdna-agent -r ' + conf_exclude_regex
      action :run
    end
  end

end
