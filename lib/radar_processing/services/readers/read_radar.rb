module RadarProcessing
  module Readers
    class ReadRadar
      def initialize(file_path)
        @file_path = file_path
      end

      def call
        Casts::StringToMatrix.new(File.read(@file_path)).call
      end
    end
  end
end
