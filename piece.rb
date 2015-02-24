class Piece
  def initialize(color, pos, symbol)
    @color = color
    @pos = pos
    @symbol = symbol
    @board = Array.new(8) { Array.new(8) { nil } }
  end

  def update_board(board)
    @board = board
  end

  def moves
    raise "Moves method not implemented"
  end
  
  def end_of_board?(pos)
    !(pos[0].between?(0,7) && pos[1].between?(0,7))
  end
end
