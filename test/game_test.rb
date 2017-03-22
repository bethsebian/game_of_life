require 'minitest/autorun'
require "./lib/game"

class GameTest < Minitest::Test
  attr_reader :game

  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, game
  end

  def test_it_has_an_origin_cell
    assert_instance_of Cell, game.origin
  end
end
