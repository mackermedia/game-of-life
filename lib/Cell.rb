class Cell
  def initialize(alive=false)
    @alive = alive
  end
  
  def is_alive=(state)
    @alive = state
  end
  
  # only purpose is to convert boolean to 0 or 1
  def get_state
    @alive ? 1 : 0
  end

end
