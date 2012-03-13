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

pipeline = emit('rolls/') |
  files_in_directory |
  select{ |x| x.start_with? 'h2011-33'} | map{ |x| "./rolls/#{x}"} |
  parse_votes |
  select{ |x| !x.nil? && x['question'].first =~ /[eE]ducation/} | run_until_exhausted

education_votes = pipeline.run

cleanup = map{ |x| { x.keys.first['question'].first => x.values.first}}

votes = each(education_votes) |
  wrap(each{ |x| x['voter']} | count_votes(reps, 'party'), :aggregated) | cleanup

puts "by party:"
3.times{ ap votes.run }


votes = each(education_votes) |
  wrap(each{ |x| x['voter']} | count_votes(reps, 'gender'), :aggregated) | cleanup

puts "by gender:"
3.times{ ap votes.run }

puts "uh oh, what the hell happened there?"
#we reused cleanup - you can't recycle stages


