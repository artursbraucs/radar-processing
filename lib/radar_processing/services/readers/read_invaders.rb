module RadarProcessing
  module Readers
    class ReadInvaders
      def initialize(dir_path)
        @dir_path = dir_path
      end

      def call
        Pathname.new(@dir_path).children.map do |path|
          Casts::StringToMatrix.new(File.read(path)).call
        end
      end
    end
  end
end
