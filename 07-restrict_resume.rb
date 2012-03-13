require 'bundler/setup'
Bundler.require
require './stages/build_people.rb'
require './stages/parse_person.rb'
require './stages/file_lines.rb'
require './stages/files_in_directory.rb'
require './stages/parse_votes.rb'
require './stages/count_votes.rb'

include Stages::Sugar

pipeline = emit('people.xml') | parse_person | build_people
reps = pipeline.run

filter = /ealth/
votes_on = emit('rolls/') |
  files_in_directory |
  select{ |x| x.start_with? 'h2011-'} | map{ |x| "./rolls/#{x}"} |
  parse_votes |
  select{ |x| !x.nil? && x['question'].first =~ filter}

cleanup = map{ |x| { x.keys.first['question'].first => x.values.first.first}}
print_title = map{ |x| puts x.keys.first; x}
print_votes = each{ |x| x.values.first.to_a} |
  map{ |x| puts "#{x[0][0]} voted #{x[0][1]} #{x[1]} times"; x}

votes = votes_on | restrict |
  each{ |x| x['voter']} | count_votes(reps, 'party') | resume |
  cleanup | print_title | print_votes | exhaust_and_count

votes.run

puts "resume assumes an array, not :aggregated"

