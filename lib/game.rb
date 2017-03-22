require './lib/cell'

class Game
  attr_reader :origin

  def initialize
    @origin = Cell.new
  end

  def transform
    origin.transform
  end

  def alive_cells_count
    @origin.condition == "alive" ? 1 : 0
  end
end
