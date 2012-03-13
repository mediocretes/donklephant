require 'stages'
require 'xmlsimple'

module Stages
  class ParseVotes < Stage
    def handle_value(value)
      votes = XmlSimple.xml_in(value)
      output votes
    end
  end
end



module Stages::Sugar
  def parse_votes
    Stages::ParseVotes.new
  end
end
