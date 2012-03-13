require 'stages'

module Stages
  class FilesInDirectory < Stage
    def handle_value(value)
      Dir.foreach(value) do |filename|
        output filename
      end
    end
  end
end

module Stages::Sugar
  def files_in_directory
    Stages::FilesInDirectory.new
  end
end
