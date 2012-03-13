require 'stages'

module Stages
  class FileLines < Stage
    def handle_value(value)
      #a filename
      File.open(value, 'r') do |f|
        while line = f.gets
          output line
        end
      end
    end
  end
end

module Stages::Sugar
  def file_lines
    Stages::FileLines.new
  end
end
