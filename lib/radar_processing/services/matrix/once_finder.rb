module RadarProcessing
  class Matrix::OnceFinder
    def initialize(matrix, tollerance: 0, matcher_class: Matrix::Match)
      @matrix = matrix
      @tollerance = tollerance
      @matcher_class = matcher_class

      @cutted_coordinates = {}
    end

    def call(other, row:, col:)
      return if @cutted_coordinates[[row, col]]

      part = @matrix.take_part(
        row: row, col: col, rows: other.row_size, cols: other.column_size
      )

      match = @matcher_class.new(part, other).call

      return unless match >= (1 - @tollerance)

      fill_cutted_coordinates(row: row, col: col, rows: other.row_size, cols: other.column_size)

      { origin: part, match: match }
    end

    private

    def fill_cutted_coordinates(row:, col:, rows:, cols:)
      (row..(row + rows - 1)).each do |x|
        (col..(col + cols - 1)).each do |y|
          @cutted_coordinates[[x, y]] = true
        end
      end
    end
  end
end
