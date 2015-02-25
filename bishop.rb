require_relative 'sliding_piece.rb'

class Bishop < SlidingPiece
  def move_dirs
    [[1, 1], [-1, -1], [1, -1], [-1, 1]]
    # moves
  end
end
