require 'bundler'
Bundler::GemHelper.install_tasks
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'


task :default => :test
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/*_test.rb'
  test.verbose = true
end

# ROOT       = File.expand_path(File.dirname(__FILE__))
# TEST_ROOT = ROOT + "/test"
# MODELS_ROOT     = TEST_ROOT + "/models"
# FIXTURES_ROOT   = TEST_ROOT + "/fixtures"
# MIGRATIONS_ROOT = TEST_ROOT + "/migrations"
# SCHEMA_ROOT     = TEST_ROOT + "/schema"
# 
# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database  => "db/test.sqlite3"
# )
# load SCHEMA_ROOT + "/schema.rb"
