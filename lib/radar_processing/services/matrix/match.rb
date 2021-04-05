module RadarProcessing
  class Matrix::Match
    def initialize(matrix, other, required_elements: 0.7)
      @matrix = matrix
      @other = other
      @required_elements = required_elements
    end

    def call
      return 0 if @matrix.count != @other.count

      return 0 if @matrix.count * @required_elements >= visable_count

      match = @matrix.combine(@other) { |a, b| a == b || a.nil? ? 1 : 0 }.sum

      (Float(match) / Float(@matrix.count))
    end

    private

    def visable_count
      @matrix.map { |a| a.nil? ? 0 : 1 }.sum
    end
  end
end
