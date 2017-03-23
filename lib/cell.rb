class Cell
  attr_reader :condition, :neighbors, :touched

  def initialize(condition = :dead)
    @condition = condition
    @next_condition = condition
    @neighbors = {}
    @touched = false
  end

  def transform
    set_next_condition_all
    untouch_all
    update_condition_all
    untouch_all
  end

  def set_next_condition_all
    @touched = true
    count = neighbors.count {|position, neighbor| neighbor.condition == :alive}
    @next_condition = :dead if count < 2 || count > 3 #
    @next_condition = :alive if count == 3
    untouched_cells.each {|neighbor| neighbor.set_next_condition_all}
  end

  def update_condition_all
    @touched = true
    @condition = @next_condition
    untouched_cells.each {|neighbor| neighbor.update_condition_all}
  end

  def untouched_cells
    neighbors.values.select {|neighbor| neighbor.touched == false}
  end

  def untouch_all
    @touched = false
    touched = neighbors.values.select {|neighbor| neighbor.touched == true}
    touched.each {|neighbor| neighbor.untouch_all }
  end

  def rouse
    @condition = @next_condition = :alive
  end

  def kill
    @condition = @next_condition = :dead
  end

  def introduce_neighbors(new_neighbors)
    neighbors.merge!(new_neighbors)
  end
end
