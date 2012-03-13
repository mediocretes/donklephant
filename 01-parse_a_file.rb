require 'bundler/setup'
Bundler.require
require './stages/file_lines.rb'

include Stages::Sugar

pipeline = emit('people.xml') | file_lines

puts pipeline.run
puts pipeline.run
puts "ok, so it parses things..."
gets
pipeline.reset!
pipeline = pipeline | exhaust_and_count
puts "line count: #{pipeline.run}"
