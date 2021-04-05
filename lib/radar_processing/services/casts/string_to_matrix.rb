module RadarProcessing
  module Casts
    class StringToMatrix
      def initialize(string)
        @string = string
      end

      def call
        Matrix[*@string.split("\n").map(&:chars)]
      end
    end
  end
end
