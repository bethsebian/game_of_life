require 'pry'

class Cell
  attr_reader :neighbors, :condition, :touched

  def initialize(condition = "dead")
    @condition = condition
    @neighbors = {}
    @touched = false
  end

  def transform
    count = @neighbors.count do |position, neighbor|
      neighbor.condition == "alive"
    end
    @condition = "dead" if count < 2 || count > 3 #
    @condition = "alive" if count == 3
    @touched = true
    untouched = neighbors.values.select {|neighbor| neighbor.touched == false }
    untouched.each {|neighbor| neighbor.transform }
  end

  def rouse
    @condition = "alive"
  end

  def introduce_neighbors(new_neighbors)
    neighbors.merge!(new_neighbors)
  end
end
