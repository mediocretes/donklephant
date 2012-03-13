require 'bundler/setup'
Bundler.require
require './stages/build_people.rb'
require './stages/parse_person.rb'

include Stages::Sugar

pipeline = emit('people.xml') | parse_person
ap pipeline.run
puts "that seems pretty good, but what if I want a useful structure?"

gets
pipeline.reset!
pipeline = pipeline | build_people

ap pipeline.run



