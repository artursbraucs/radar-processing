module RadarProcessing
  class Matrix < ::Matrix
    def take_part(row:, col:, rows:, cols:)
      data = (row..(row + rows - 1)).map do |x|
        (col..(col + cols - 1)).map do |y|
          self[x, y]
        end
      end

      RadarProcessing::Matrix[*data]
    end

    def to_joined_string
      to_a.map(&:join).join("\n")
    end
  end
end
