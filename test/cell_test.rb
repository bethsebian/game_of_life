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

  def test_can_change_condition
    cell.condition = "alive"

    assert_equal "alive", cell.condition
  end

  def test_it_has_empty_neighbors_at_birth
    expected = {"TL" => nil,
                "TC" => nil,
                "TR" => nil,
                "L" => nil,
                "R" => nil,
                "BL" => nil,
                "BC" => nil,
                "BR" => nil}

    assert_equal expected, cell.neighbors
  end

  def test_it_dies_if_all_neighbors_are_dead
    cell.condition = "alive"
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
    cell.condition = "alive"
    c_1 = Cell.new
    c_2 = Cell.new
    cell.neighbors["TL"] = c_1
    cell.neighbors["TC"] = c_2
    cell.neighbors["TL"].condition = "alive"
    cell.neighbors["TC"].condition = "alive"
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
    cell.condition = "alive"
    c_1 = Cell.new
    c_2 = Cell.new
    c_3 = Cell.new
    c_4 = Cell.new
    cell.neighbors["TL"] = c_1
    cell.neighbors["TC"] = c_2
    cell.neighbors["TR"] = c_3
    cell.neighbors["L"] = c_4
    cell.neighbors["TL"].condition = "alive"
    cell.neighbors["TC"].condition = "alive"
    cell.neighbors["TR"].condition = "alive"
    cell.neighbors["L"].condition = "alive"
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
    cell.neighbors["TL"].condition = "alive"
    cell.neighbors["TC"].condition = "alive"
    cell.neighbors["TR"].condition = "alive"
    cell.neighbors["L"] = Cell.new
    cell.neighbors["R"] = Cell.new
    cell.neighbors["BL"] = Cell.new
    cell.neighbors["BC"] = Cell.new
    cell.neighbors["BR"] = Cell.new
    cell.transform

    assert_equal "alive", cell.condition
  end
end
