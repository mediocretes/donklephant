require 'stages'
require 'rexml/parsers/pullparser'
require 'ostruct'

module Stages
  class ParsePerson < Stage
    def handle_value(value)
      parser = REXML::Parsers::PullParser.new(IO.read(value))
      while parser.has_next?
        node = parser.pull
        next unless node.start_element?
        next unless node[0] == 'person'
        attrs = node[1]
        parser.pull
        rolenode = parser.pull
        attrs.merge!(rolenode[1])
        output OpenStruct.new(attrs)
      end
    end
  end
end



module Stages::Sugar
  def parse_person
    Stages::ParsePerson.new
  end
end
