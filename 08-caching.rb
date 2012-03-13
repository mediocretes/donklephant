require 'bundler/setup'
Bundler.require
require './stages/build_people.rb'
require './stages/parse_person.rb'
require './stages/file_lines.rb'
require './stages/files_in_directory.rb'
require './stages/parse_votes.rb'
require './stages/count_votes.rb'

include Stages::Sugar

some_open_cursor = emit('people.xml') | parse_person
some_long_running_stage = map{ |x| x}
ping = map{ |x| print '+'; x}
pong = map{ |x| print '-'; x}

pipeline = some_open_cursor | ping | some_long_running_stage | pong | run_until_exhausted
pipeline.run

puts "that's bad - use the cache stage before you start a long stage"



