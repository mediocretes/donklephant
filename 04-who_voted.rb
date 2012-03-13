require 'bundler/setup'
Bundler.require
require './stages/build_people.rb'
require './stages/parse_person.rb'
require './stages/file_lines.rb'
require './stages/files_in_directory.rb'
require './stages/parse_votes.rb'

include Stages::Sugar

pipeline = emit('people.xml') | parse_person | build_people
reps = pipeline.run

pipeline = emit('rolls/') | files_in_directory |
  select{ |x| x.end_with? '.xml'} | map{ |x| "./rolls/#{x}"} |
  parse_votes |
  wrap(map{ |x| x['voter']} | each | map{ |x| reps[x['id']].party } | group, :aggregated) |
  map{ |x| { x.keys.first['question'] => x.values.first}}

5.times do
  puts pipeline.run
end



