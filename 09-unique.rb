require 'bundler/setup'
Bundler.require
require './stages/build_people.rb'
require './stages/parse_person.rb'
require './stages/file_lines.rb'
require './stages/files_in_directory.rb'
require './stages/parse_votes.rb'
require './stages/count_votes.rb'

include Stages::Sugar

#never ever emit nil unless you mean it!
pull_value = map{ |x| r = x.religion; r.nil? ? 'none' : r}
uniq =  unique | run_until_exhausted


pipeline = emit('people.xml') | parse_person | pull_value | run_until_exhausted

puts pipeline.run

puts "that's a lot to read for such a simple question - let's clean it up with unique/group"

