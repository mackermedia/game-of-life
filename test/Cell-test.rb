$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'test/unit'
require 'Cell'

class CellTest < Test::Unit::TestCase
  def test_cell_alive
    c1 = Cell.new
    assert_equal(0, c1.get_state)
    c1.is_alive = true
    assert_equal(1, c1.get_state)
    c2 = Cell.new(true)
    assert_equal(1, c2.get_state)
  end

end
