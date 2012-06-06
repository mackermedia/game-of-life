$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'test/unit'
require 'GameBoard'

class GameBoardTest < Test::Unit::TestCase
  def setup
    @gb1 = GameBoard.new
    @gb1.populate("0 1 0 0 0\n1 0 0 1 1\n1 1 0 0 1\n0 1 0 0 0\n1 0 0 0 1\n")
  end

  def test_board_size
    gb1 = GameBoard.new
    assert_equal(5, gb1.size)
    gb2 = GameBoard.new(10)
    assert_equal(10, gb2.size)
  end

  def test_cell_addressable
    assert_equal(0, @gb1[0, 0])
    assert_equal(1, @gb1[1, 0])
    assert_equal(0, @gb1[2, 0])
    assert_equal(1, @gb1[0, 1])
    assert_equal(1, @gb1[0, 2])
  end

  def test_under_population
    @gb1.evolve
    assert_equal(0, @gb1[1, 0])
  end

  def test_survival
    @gb1.evolve
    assert_equal(1, @gb1[0, 1])
  end

  def test_overcrowding
    @gb1.live(1, 1)
    @gb1.evolve
    assert_equal(0, @gb1[1, 2])
  end

  def test_reproduction
    @gb1.evolve
    assert_equal(1, @gb1[2, 1])
  end

  def test_board_reproduces
    assert_not_equal(@gb1.to_s, @gb1.evolve.to_s)
  end

  def test_correct_evolution
    @gb1.evolve
    assert_equal("0 0 0 0 0\n1 0 1 1 1\n1 1 1 1 1\n0 1 0 0 0\n0 0 0 0 0\n", @gb1.to_s)
  end

end
