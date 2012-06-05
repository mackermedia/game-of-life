require './GameBoard'

class GameOfLife
  def initialize
    board_str = ""

    # handle seed files as argument
    if ARGV.length == 1
      filepath = ARGV[0]
      File.open(filepath) do |file|
        file.each_line { |line| board_str += line }
      end
    else
      #prompt user for input
      puts "Please input your game board. Use 0 or 1 for each cell."
      puts "Insert a new blank line to indicate you are finished."
      
      while line = gets
        break if line == "\n" 
        board_str += line
      end
    end
    
    # do one iteration and print
    gb = GameBoard.new(5, board_str)
    gb.evolve
    gb.display
  end

end

GameOfLife.new