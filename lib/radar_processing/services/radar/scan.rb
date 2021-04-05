module RadarProcessing
  module Radar
    class Scan
      def initialize(radar, finder:, known_invaders: [])
        @radar = radar
        @known_invaders = known_invaders

        @finder = finder
      end

      def call
        @found_matches = {}

        @known_invaders.each do |invader|
          search_for_invader(invader)
        end

        @found_matches
      end

      private

      def search_for_invader(invader)
        rows = invader.row_size
        cols = invader.column_size

        @radar.each_with_index do |_, row, col|
          search_in_row = row - rows / 2
          search_in_col = col - cols / 2

          process_match_in_place(invader, row: search_in_row, col: search_in_col)
        end
      end

      def process_match_in_place(invader, row:, col:)
        result = @finder.call(invader, row: row, col: col)
        return if result.nil?

        @found_matches[[row, col]] = result.merge({ invader: invader })
      end
    end
  end
end
