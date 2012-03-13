require 'stages'

module Stages
  class BuildPeople < Stage
    def process
      cache = { }
      while v = input
        cache[v.id] = v
      end
      output cache
    end
  end
end



module Stages::Sugar
  def build_people
    Stages::BuildPeople.new
  end
end
