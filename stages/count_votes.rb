require 'stages'
require 'xmlsimple'

module Stages
  class CountVotes < Stage
    def initialize(reps, key)
      @reps = reps
      @key = key
      super()
    end

    def process
      cache = Hash.new{ |h,k| h[k] = 0}
      while vote = input
        key_value = @reps[vote['id']].send @key
        vote = vote['vote']
        vote = 'N/A' if vote == '0'
        cache[[key_value, vote]] += 1
      end
      output cache
    end
  end
end



module Stages::Sugar
  def count_votes(*args)
    Stages::CountVotes.new(*args)
  end
end
