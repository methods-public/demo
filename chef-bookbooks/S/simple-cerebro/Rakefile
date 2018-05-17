#!/usr/bin/env rake
require 'rake'
require 'rspec/core/rake_task'

cookbook_dir = File.expand_path File.dirname(__FILE__)
ENV['BERKSHELF_PATH'] = cookbook_dir + '/.berkshelf'
ENV['CI_REPORTS'] = cookbook_dir + '/reports'

task default: 'quick'

begin
  require 'foodcritic'

  FoodCritic::Rake::LintTask.new do |t|
    t.options = {
      progress: true,
      fail_tags: %w(any)
    }
  end
rescue LoadError
  warn 'Foodcritic Is missing ZOMG'
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.fail_on_error = true
  end
rescue LoadError
  warn 'Rubocop gem not installed, now the code will look like crap!'
end

desc 'Run all of the quick tests.'
task :quick do
  Rake::Task['rubocop'].invoke
  Rake::Task['foodcritic'].invoke
end
