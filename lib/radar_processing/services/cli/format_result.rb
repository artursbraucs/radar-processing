module RadarProcessing
  module Cli
    class FormatResult
      def initialize(rows:, cols:, result: {})
        @rows = rows
        @cols = cols
        @result = result
      end

      def call
        output = [">> Total matched count: #{@result.size}"]
        output += header_row
        output += formated_result_table

        output << ''
        output << build_clean_radar.to_joined_string

        output.join("\n")
      end

      private

      def header_row
        [
          "| #{'Location'.ljust(10)} | #{'Match'.ljust(10)} |",
          '| ---------- | ---------- |'
        ]
      end

      def formated_result_table
        @result.map do |coord, part|
          "| #{coord.to_s.ljust(10)} | #{part[:match].round(2).to_s.ljust(10)} |"
        end
      end

      def build_clean_radar
        Matrix::ReplaceElements.
          new(
            Matrix.build(@rows, @cols) { '-' },
            replace_with: only_invaders_data
          ).call
      end

      def only_invaders_data
        @result.transform_values { |data| data[:invader] }
      end
    end
  end
end
