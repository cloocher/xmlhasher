require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/*/*_test.rb'
  t.verbose = true
end

desc "Run the benchmarks"
task :benchmark do
  system("ruby", File.join(File.dirname(__FILE__), "benchmark", "benchmark.rb"))
end

task :default => :test
