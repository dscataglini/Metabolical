require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'minitest/autorun'

TEST_ROOT       = File.expand_path(File.dirname(__FILE__) )
MODELS_ROOT     = TEST_ROOT + "/models"
FIXTURES_ROOT   = TEST_ROOT + "/fixtures"
MIGRATIONS_ROOT = TEST_ROOT + "/migrations"
SCHEMA_ROOT     = TEST_ROOT + "/schema"

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database  => "db/test.sqlite3"
)

load SCHEMA_ROOT + "/schema.rb"