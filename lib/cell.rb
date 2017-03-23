require 'pry'

class Cell
  attr_reader :neighbors, :condition, :touched

  def initialize(condition = "dead")
    @condition = condition
    @next_condition = condition
    @neighbors = {}
    @touched = false
  end

  def transform
    touch_and_transform_all
    untouch_all
    update_condition_all
    untouch_all
  end

  def touch_and_transform_all
    count = @neighbors.count do |position, neighbor|
      neighbor.condition == "alive"
    end
    @next_condition = "dead" if count < 2 || count > 3 #
    @next_condition = "alive" if count == 3
    @touched = true
    untouched = neighbors.values.select {|neighbor| neighbor.touched == false}
    untouched.each {|neighbor| neighbor.touch_and_transform_all}
  end

  def update_condition_all
    @touched = true
    @condition = @next_condition
    untouched = neighbors.values.select {|neighbor| neighbor.touched == false}
    untouched.each {|neighbor| neighbor.update_condition_all}
  end

  def untouch_all
    @touched = false
    touched = neighbors.values.select {|neighbor| neighbor.touched == true}
    touched.each {|neighbor| neighbor.untouch_all }
  end

  def rouse
    @condition = @next_condition = "alive"
  end

  def kill
    @condition = @next_condition = "dead"
  end

  def introduce_neighbors(new_neighbors)
    neighbors.merge!(new_neighbors)
  end
end
