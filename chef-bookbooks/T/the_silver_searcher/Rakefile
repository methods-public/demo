require 'rubocop/rake_task'
require 'foodcritic'

RuboCop::RakeTask.new
FoodCritic::Rake::LintTask.new

task :default => [:rubocop, :foodcritic]
