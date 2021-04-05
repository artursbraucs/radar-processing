require 'matrix'
require 'pathname'

require_relative 'radar_processing/core/matrix'
require_relative 'radar_processing/services/readers/read_radar'
require_relative 'radar_processing/services/readers/read_invaders'
require_relative 'radar_processing/services/casts/string_to_matrix'
require_relative 'radar_processing/services/matrix/once_finder'
require_relative 'radar_processing/services/matrix/match'
require_relative 'radar_processing/services/matrix/replace_elements'
require_relative 'radar_processing/services/radar/scan'
require_relative 'radar_processing/services/cli/format_result'

module RadarProcessing
  TOLLERANCE = 0.25
  private_constant :TOLLERANCE

  RADAR_INPUT_LOCATION = "#{__dir__}/../data/radar".freeze
  private_constant :RADAR_INPUT_LOCATION

  INVADERS_INPUT_LOCATION = "#{__dir__}/../data/invaders".freeze
  private_constant :INVADERS_INPUT_LOCATION

  def self.run
    radar = Readers::ReadRadar.new(RADAR_INPUT_LOCATION).call
    invaders = Readers::ReadInvaders.new(INVADERS_INPUT_LOCATION).call

    result = Radar::Scan.new(
      radar,
      known_invaders: invaders,
      finder: Matrix::OnceFinder.new(radar, tollerance: TOLLERANCE)
    ).call

    Cli::FormatResult.new(rows: radar.row_size, cols: radar.column_size, result: result).call
  end
end
