require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


task :console do
  require 'pry'
  require 'sberbank/acquiring' # You know what to do.

  def reload!
    # Change 'my_gem' here too:
    $LOADED_FEATURES
      .select { |feat| feat =~ /\/sberbank\// }
      .each { |file| load file }
  end

  pry
end
