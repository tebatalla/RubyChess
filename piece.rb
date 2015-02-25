class Piece
  attr_reader :color, :symbol
  attr_accessor :pos

  def initialize(color, pos, symbol)
    @color = color
    @pos = pos
    @symbol = symbol
  end

  def inspect
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

  def move_into_check?(pos)
    board_dup = @board.dup
    board_dup.move!(@pos, pos)
    board_dup.in_check?(@color)
  end

  def valid_move?(pos)
    (@board[pos].nil? || @board.opponent_piece?(pos, @color)) &&
      !end_of_board?(pos)
  end
end
