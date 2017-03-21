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
    expected = %w(top_left top_center top_right left right bottom_left bottom_center bottom_right)

    assert_equal expected, Cell::NEIGHBORS
  end

  def test_it_dies_if_all_neighbors_are_dead
    cell.rouse
    cell.neighbors["TL"] = Cell.new
    cell.neighbors["TC"] = Cell.new
    cell.neighbors["TR"] = Cell.new
    cell.neighbors["L"] = Cell.new
    cell.neighbors["R"] = Cell.new
    cell.neighbors["BL"] = Cell.new
    cell.neighbors["BC"] = Cell.new
    cell.neighbors["BR"] = Cell.new
    cell.transform

    assert_equal "dead", cell.condition
  end

  def test_it_survives_if_two_neighbors_are_alive
    cell.rouse
    c_1 = Cell.new
    c_2 = Cell.new
    cell.neighbors["TL"] = c_1
    cell.neighbors["TC"] = c_2
    cell.neighbors["TL"].rouse
    cell.neighbors["TC"].rouse
    cell.neighbors["TR"] = Cell.new
    cell.neighbors["L"] = Cell.new
    cell.neighbors["R"] = Cell.new
    cell.neighbors["BL"] = Cell.new
    cell.neighbors["BC"] = Cell.new
    cell.neighbors["BR"] = Cell.new
    cell.transform

    assert_equal "alive", cell.condition
  end

  def test_it_dies_if_four_neighbors_are_alive
    cell.rouse
    c_1 = Cell.new
    c_2 = Cell.new
    c_3 = Cell.new
    c_4 = Cell.new
    cell.neighbors["TL"] = c_1
    cell.neighbors["TC"] = c_2
    cell.neighbors["TR"] = c_3
    cell.neighbors["L"] = c_4
    cell.neighbors["TL"].rouse
    cell.neighbors["TC"].rouse
    cell.neighbors["TR"].rouse
    cell.neighbors["L"].rouse
    cell.neighbors["R"] = Cell.new
    cell.neighbors["BL"] = Cell.new
    cell.neighbors["BC"] = Cell.new
    cell.neighbors["BR"] = Cell.new
    cell.transform

    assert_equal "dead", cell.condition
  end

  def test_it_becomes_alive_if_three_neighbors_are_alive
    c_1 = Cell.new
    c_2 = Cell.new
    c_3 = Cell.new
    cell.neighbors["TL"] = c_1
    cell.neighbors["TC"] = c_2
    cell.neighbors["TR"] = c_3
    cell.neighbors["TL"].rouse
    cell.neighbors["TC"].rouse
    cell.neighbors["TR"].rouse
    cell.neighbors["L"] = Cell.new
    cell.neighbors["R"] = Cell.new
    cell.neighbors["BL"] = Cell.new
    cell.neighbors["BC"] = Cell.new
    cell.neighbors["BR"] = Cell.new
    cell.transform

    assert_equal "alive", cell.condition
  end
end
