require 'minitest/autorun'
require './lib/cell'
require './test/cell_matrix'

class CellTest < Minitest::Test
  include CellMatrix
  attr_reader :cell

  def setup
    @cell = Cell.new
  end

  def test_it_exist
    assert_instance_of Cell, Cell.new
  end

  def test_default_condition_is_dead
    assert_equal :dead, cell.condition
  end

  def test_it_can_rouse
    alive = Cell.new(:alive)

    assert_equal :alive, alive.condition
  end

  def test_it_can_kill
    alive = Cell.new(:alive)
    alive.kill

    assert_equal :dead, alive.condition
  end

  def test_can_change_condition
    alive = Cell.new(:alive)

    assert_equal :alive, alive.condition
  end

  def test_cell_is_created_with_empty_neighbor_cells
    assert_equal Hash.new, cell.neighbors
  end

  def test_it_dies_if_all_neighbors_are_dead
    alive = Cell.new(:alive)
    alive.transform

    assert_equal :dead, alive.condition
  end

  def test_it_connects_with_neighbors
    new_neighbors = {top_left: Cell.new,
                     top_center: Cell.new}
    cell.introduce_neighbors(new_neighbors)

    assert_equal new_neighbors, cell.neighbors
  end

  def test_it_connects_with_neighbors_multiple_times
    new_neighbors_1 = {top_left: Cell.new,
                       top_center: Cell.new}
    new_neighbors_2 = {bottom_left: Cell.new,
                       bottom_center: Cell.new}
    cell.introduce_neighbors(new_neighbors_1)
    cell.introduce_neighbors(new_neighbors_2)

    expected = new_neighbors_1.merge(new_neighbors_2)
    assert_equal expected, cell.neighbors
  end

  def test_it_survives_if_two_neighbors_are_alive
    # 17      19
    #     25
    cells = cell_matrix
    origin = cells[25]
    origin.rouse
    cells[17].rouse
    cells[19].rouse
    cells[25].transform
    assert_equal :alive, origin.condition
  end

  def test_it_dies_if_four_neighbors_are_alive
    # 17  18  19
    #     25  26
    cells = cell_matrix
    origin = cells[25]
    origin.rouse
    cells[17].rouse
    cells[18].rouse
    cells[19].rouse
    cells[26].rouse
    origin.transform

    assert_equal :dead, origin.condition
  end

  def test_it_becomes_alive_if_three_neighbors_are_alive
    # 17  18  19
    #     25
    cells = cell_matrix
    origin = cells[25]
    cells[17].rouse
    cells[18].rouse
    cells[19].rouse
    origin.transform

    assert_equal :alive, origin.condition
  end

  def test_neighbors_transform_also
    # 25  26
    # 32  33
    cells = cell_matrix
    origin = cells[25]
    origin.rouse
    cells[26].rouse
    cells[33].rouse
    origin.transform

    assert_equal :alive, origin.condition
    assert_equal :alive, cells[26].condition
    assert_equal :alive, cells[32].condition
    assert_equal :alive, cells[33].condition
  end

  def test_neighbors_transform_correctly_multiple_times_requiring_untouch
    # 25  26  |  X O    O O     X X    X X
    # 32  33  |  O X => O O =!> O X => X X
    cells = cell_matrix
    origin = cells[25]
    origin.rouse
    cells[33].rouse
    origin.transform
    origin.rouse
    cells[26].rouse
    cells[33].rouse
    origin.transform

    assert_equal :alive, origin.condition
    assert_equal :alive, cells[26].condition
    assert_equal :alive, cells[32].condition
    assert_equal :alive, cells[33].condition
  end

  def test_neighbors_transform_by_consulting_neighbors_untransformed_position
    # 24  25      |  X X O    O X O
    #     32  33  |  O O X => O X O
    cells = cell_matrix
    origin = cells[25]
    origin.rouse
    cells[24].rouse
    cells[33].rouse
    origin.transform

    assert_equal :alive, origin.condition
    assert_equal :alive, cells[32].condition
  end

  def test_successfully_transforms_block_seed
    cells = block_matrix

    [25,26,32,33].each { |num| assert_equal :alive, cells[num].condition }

    cells[25].transform

    [25,26,32,33].each { |num| assert_equal :alive, cells[num].condition }
  end

  def test_successfully_transforms_beehive_seed
    cells = beehive_matrix

    [18,19,24,27,32,33].each { |num| assert_equal :alive, cells[num].condition }

    cells[18].transform

    [18,19,24,27,32,33].each { |num| assert_equal :alive, cells[num].condition }
  end

  def test_successfully_transforms_beacon_seed
    cells = beacon_matrix

    [9,10,16,26,32,33].each { |num| assert_equal :alive, cells[num].condition }
    [17,25].each { |num| assert_equal :dead, cells[num].condition }

    cells[18].transform

    [9,10,16,17,25,26,32,33].each { |num| assert_equal :alive, cells[num].condition }
  end

  def test_successfully_transforms_beacon_seed
    cells = glider_matrix

    [2,10,15,16,17].each { |num| assert_equal :alive, cells[num].condition }

    cells[2].transform

    [8,10,16,17,23].each { |num| assert_equal :alive, cells[num].condition }
    [2,15].each { |num| assert_equal :dead, cells[num].condition }

    cells[8].transform

    [10,15,17,23,24].each { |num| assert_equal :alive, cells[num].condition }
    [8,16].each { |num| assert_equal :dead, cells[num].condition }

    cells[10].transform

    [9,17,18,23,24].each { |num| assert_equal :alive, cells[num].condition }
    [10,15].each { |num| assert_equal :dead, cells[num].condition }

    cells[9].transform

    [10,18,23,24,25].each { |num| assert_equal :alive, cells[num].condition }
    [9,17].each { |num| assert_equal :dead, cells[num].condition }
  end
end
