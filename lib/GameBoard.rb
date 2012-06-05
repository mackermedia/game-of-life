require './Cell'

class GameBoard
  attr_reader :size, :board

  def initialize(size=5, init_string=nil)
    init_board(size)
    if init_string.nil?
      randomize_population
    else
      populate(init_string)
    end
  end
  
  def randomize_population
    @board.each do |row|
      row.each do |cell|
        if rand(2) == 1
          cell.is_alive = true
        else
          cell.is_alive = false
        end
      end
    end
  end
  
  def init_board(size)
    @size = size
    @board = Array.new(size) { Array.new(size) { Cell.new(false) } }
  end
  
  def populate(init_string)
    first_pass = true
    lines = init_string.split("\n")
    lines.each_with_index do |line, line_index|
      values = line.chomp.split(" ")
      if first_pass
        init_board(values.length)
        first_pass = false
      end
      values.each_with_index do |val, val_index|
         @board[line_index][val_index] = Cell.new(val == "1")
      end
    end
  end

  def [](x, y)
    @board[y][x].get_state
  end

  def live(x, y)
    @board[y][x].is_alive = true
  end

  def die(x, y)
    @board[y][x].is_alive = false
  end

  def evolve
    next_generation = GameBoard.new(@board.size)
    @board.size.times do |x|
      @board.size.times do |y|
        fate(x, y) ? next_generation.live(x, y) : next_generation.die(x, y)
      end
    end
    @board = next_generation.board
  end

  def fate(x, y)
    left = [0, x-1].max
    right = [x+1, @board.size-1].min
    top = [0, y-1].max
    bottom = [y+1, @board.size-1].min

    num_live_neigbors = 0

    for i in (left..right)
      for j in (top..bottom)
        num_live_neigbors += self[i, j] unless (i == x and j == y)
      end
    end

    # if alive & less than 2 alive, die
    # if alive with 2 or 3 alive, live
    # if alive with 3+ alive, die
    # if dead with 3 alive, live!
    # only return true in instances where life is sustained or created
    return ((self[x, y] == 1 and (num_live_neigbors == 2 or num_live_neigbors == 3)) or (num_live_neigbors == 3 and self[x, y] == 0))
  end

  def generate_board_string
    board_str = ""
    @board.each do |row|
      row_str = ""
      row.each do |cell|
        row_str += "#{cell.get_state.to_s} "
      end
      board_str += row_str.rstrip + "\n"
    end
    return board_str
  end
  
  def display
    puts self
  end

  def to_s
    generate_board_string
  end
end
