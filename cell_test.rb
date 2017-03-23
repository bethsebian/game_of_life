require 'minitest/autorun'
require './cell'

class CellTest < Minitest::Test
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
    origin = Cell.new(:alive)
    top_left = Cell.new(:alive)
    top_right = Cell.new(:alive)
    origin.introduce_neighbors({top_left: top_left})
    origin.introduce_neighbors({top_right: top_right})
    origin.transform
    assert_equal :alive, origin.condition
  end

  def test_it_dies_if_four_neighbors_are_alive
    origin = Cell.new(:alive)
    top_left = Cell.new(:alive)
    top_center = Cell.new(:alive)
    top_right = Cell.new(:alive)
    right = Cell.new(:alive)
    origin.introduce_neighbors({top_left: top_left,
                                top_center: top_center,
                                top_right: top_right,
                                right: right})
    origin.transform

    assert_equal :dead, origin.condition
  end

  def test_it_becomes_alive_if_three_neighbors_are_alive
    origin = Cell.new
    top_left = Cell.new(:alive)
    top_center = Cell.new(:alive)
    top_right = Cell.new(:alive)
    origin.introduce_neighbors({top_left: top_left,
                              top_center: top_center,
                              top_right: top_right})
    origin.transform

    assert_equal :alive, origin.condition
  end

  def test_neighbors_transform_also
    # XX    XX
    # OX => XX
    origin = Cell.new(:alive)
    alive_1 = Cell.new(:alive)
    alive_2 = Cell.new(:alive)
    dead_1 = Cell.new
    origin.introduce_neighbors({right: alive_1,
                              bottom_center: dead_1,
                              bottom_right: alive_2})
    alive_1.introduce_neighbors({left: origin,
                              bottom_left: dead_1,
                              bottom_center: alive_2})
    alive_2.introduce_neighbors({top_left: origin,
                              top_center: alive_1,
                              left: dead_1})
    dead_1.introduce_neighbors({top_center: origin,
                              top_right: alive_1,
                              right: alive_2})
    assert_equal :alive, origin.neighbors[:right].condition

    origin.transform

    assert_equal :alive, origin.condition
    assert_equal :alive, origin.neighbors[:right].condition
    assert_equal :alive, origin.neighbors[:bottom_center].condition
    assert_equal :alive, origin.neighbors[:bottom_right].condition
  end

  def test_neighbors_transform_correctly_multiple_times_requiring_untouch
    # XO    OO        XX    XX
    # OX => OO MANUAL OX => XX
    origin = Cell.new(:alive)
    top_right = Cell.new
    bottom_left = Cell.new
    bottom_right = Cell.new(:alive)
    origin.introduce_neighbors({right: top_right,
                              bottom_center: bottom_left,
                              bottom_right: bottom_right})
    top_right.introduce_neighbors({left: origin,
                              bottom_left: bottom_left,
                              bottom_center: bottom_right})
    bottom_left.introduce_neighbors({top_right: top_right,
                              top_center: origin,
                              bottom_right: bottom_right})
    bottom_right.introduce_neighbors({top_center: top_right,
                              top_left: origin,
                              left: bottom_left})
    origin.transform
    origin.rouse
    top_right.rouse
    bottom_right.rouse
    origin.transform

    assert_equal :alive, origin.condition
    assert_equal :alive, origin.neighbors[:right].condition
    assert_equal :alive, origin.neighbors[:bottom_center].condition
    assert_equal :alive, origin.neighbors[:bottom_right].condition
  end

  def test_neighbors_transform_by_consulting_neighbors_untransformed_position
    # XXO    OXO  XXO
    # OOX => OXO  OOX
    top_left = Cell.new(:alive)
    top_center = Cell.new(:alive)
    top_right = Cell.new
    bottom_left = Cell.new
    bottom_center = Cell.new
    bottom_right = Cell.new(:alive)
    top_left.introduce_neighbors({
                                  right: top_center,
                                  bottom_center: bottom_left,
                                  bottom_right: bottom_center})
    top_center.introduce_neighbors({
                                  left: top_left,
                                  right: top_right,
                                  bottom_left: bottom_left,
                                  bottom_center: bottom_center,
                                  bottom_right: bottom_right})
    top_right.introduce_neighbors({
                                  left: top_center,
                                  bottom_left: bottom_center,
                                  bottom_center: bottom_right})
    bottom_left.introduce_neighbors({
                                  top: top_left,
                                  top_right: top_center,
                                  right: bottom_center})
    bottom_center.introduce_neighbors({
                                  top_left: top_left,
                                  top_center: top_center,
                                  top_right: top_right,
                                  left: bottom_left,
                                  right: bottom_right})
    bottom_right.introduce_neighbors({
                                  top_left: top_center,
                                  top_center: top_right,
                                  left: bottom_center})
    top_left.transform

    assert_equal :alive, top_center.condition
    assert_equal :alive, bottom_center.condition
  end
end
