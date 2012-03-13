require 'bundler/setup'
Bundler.require
require './stages/files_in_directory.rb'

include Stages::Sugar

pipeline = emit('./rolls/') | files_in_directory

puts pipeline.run
puts pipeline.run
puts "whats the whole directory look like?"
gets
pipeline.reset!
pipeline = pipeline | run_until_exhausted
ap pipeline.run
