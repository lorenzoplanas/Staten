require 'mongoid'
require 'rspec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
MODELS = File.join(File.dirname(__FILE__), "../models")
$LOAD_PATH.unshift(MODELS)
Dir[ File.join(MODELS, "*.rb") ].sort.each { |file| require File.basename(file) }

Mongoid.configure { |config| config.master = Mongo::Connection.new.db("staten_test") }
Rspec.configure do |config|
  config.after :suite do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end
