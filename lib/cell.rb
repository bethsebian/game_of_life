require 'pry'

class Cell
  attr_reader :neighbors
  attr_accessor :condition

  def initialize(neighbors)
    @condition = "dead"
    @neighbors = {"TL" => nil,
                "TC" => nil,
                "TR" => nil,
                "L" => nil,
                "R" => nil,
                "BL" => nil,
                "BC" => nil,
                "BR" => nil}.merge(neighbors)
  end

  def transform
    count = @neighbors.count do |position, neighbor|
      neighbor.condition == "alive"
    end
    @next_condition = "dead" if count < 2 || count > 3 #
    @next_condition = "alive" if count == 3
  end

  def update
    @condition = @next_condition
  end
end
