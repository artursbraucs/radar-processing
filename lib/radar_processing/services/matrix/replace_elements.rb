module RadarProcessing
  class Matrix::ReplaceElements
    def initialize(matrix, replace_with: {})
      @matrix = matrix.dup
      @replace_with = replace_with
    end

    def call
      @replace_with.each do |coord, replacement|
        replace_in(row: coord[0], col: coord[1], with: replacement)
      end

      @matrix
    end

    private

    def replace_in(row:, col:, with:)
      with.each_with_index do |element, r_row, r_col|
        x = row + r_row
        y = col + r_col

        next if x + 1 > @matrix.row_size || x.negative?
        next if y + 1 > @matrix.column_size || y.negative?

        @matrix[x, y] = element
      end
    end
  end
end
