require 'minitest/autorun'
require './lib/cell'

class CellTest < Minitest::Test
  attr_reader :cell

  def setup
    @cell = Cell.new
  end

  def test_it_exist
    assert_instance_of Cell, Cell.new
  end

  def test_default_condition_is_dead
    assert_equal "dead", cell.condition
  end

  def test_it_can_rouse
    cell.rouse

    assert_equal "alive", cell.condition
  end

  def test_can_change_condition
    cell.rouse

    assert_equal "alive", cell.condition
  end

  def test_it_can_access_list_of_neighbors
    expected = [:top_left,:top_center,:top_right,:left,:right,:bottom_left,:bottom_center,:bottom_right]

    assert_equal expected, Cell::NEIGHBOR_POSITIONS
  end

  def test_cell_is_created_with_empty_neighbor_cells
    assert_equal Hash.new, cell.neighbors
  end

  def test_it_dies_if_all_neighbors_are_dead
    cell.rouse
    cell.transform

    assert_equal "dead", cell.condition
  end

  def test_it_connects_with_neighbors
    new_neighbors = {top_left: Cell.new, top_center: Cell.new}
    cell.introduce_neighbors(new_neighbors)

    assert_equal new_neighbors, cell.neighbors
  end

  def test_it_connects_with_neighbors_multiple_times
    new_neighbors_1 = {top_left: Cell.new, top_center: Cell.new}
    new_neighbors_2 = {bottom_left: Cell.new, bottom_center: Cell.new}
    cell.introduce_neighbors(new_neighbors_1)
    cell.introduce_neighbors(new_neighbors_2)

    expected = new_neighbors_1.merge(new_neighbors_2)
    assert_equal expected, cell.neighbors
  end

  def test_it_survives_if_two_neighbors_are_alive
    cell.rouse
    cell_1 = Cell.new
    cell_2 = Cell.new
    cell_1.rouse
    cell_2.rouse
    cell.introduce_neighbors({top_left: cell_1})
    cell.introduce_neighbors({top_right: cell_2})
    cell.transform
    assert_equal "alive", cell.condition
  end

  def test_it_dies_if_four_neighbors_are_alive
    cell.rouse
    cell_1 = Cell.new("alive")
    cell_2 = Cell.new("alive")
    cell_3 = Cell.new("alive")
    cell_4 = Cell.new("alive")
    cell.introduce_neighbors({top_left: cell_1, top_center: cell_2, top_right: cell_3, right: cell_4})
    cell.transform

    assert_equal "dead", cell.condition
  end

  def test_it_becomes_alive_if_three_neighbors_are_alive
    cell_1 = Cell.new("alive")
    cell_2 = Cell.new("alive")
    cell_3 = Cell.new("alive")
    cell.introduce_neighbors({top_left: cell_1, top_center: cell_2, top_right: cell_3})
    cell.transform

    assert_equal "alive", cell.condition
  end
end
