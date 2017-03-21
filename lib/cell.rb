require 'pry'

class Cell
  NEIGHBORS = %w(top_left top_center top_right left right bottom_left bottom_center bottom_right)
  attr_reader :neighbors, :condition

  def initialize
    @condition = "dead"
    @neighbors = {"TL" => nil,
                "TC" => nil,
                "TR" => nil,
                "L" => nil,
                "R" => nil,
                "BL" => nil,
                "BC" => nil,
                "BR" => nil}
  end


  def transform
    count = @neighbors.count do |position, neighbor|
      neighbor.condition == "alive"
    end
    @condition = "dead" if count < 2 || count > 3 #
    @condition = "alive" if count == 3
  end

  def rouse
    @condition = "alive"
  end
end
