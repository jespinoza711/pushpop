$stdout.sync = true

$: << File.join(File.dirname(__FILE__), './lib')

require 'rspec/core/rake_task'
desc 'Run Rspec unit tests'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

namespace :jobs do
  desc 'Describe jobs'
  task :describe do
    load "#{File.dirname(__FILE__)}/Pushfile"
    Pushover.jobs.each do |job|
      puts job.name
    end
  end

  task :test do
    load "#{File.dirname(__FILE__)}/Pushfile"
    Pushover.run!
  end

  task :run do
    load "#{File.dirname(__FILE__)}/Pushfile"
    Pushover.schedule!
    Clockwork.manager.run
  end
end