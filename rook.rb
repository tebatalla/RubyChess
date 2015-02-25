require_relative 'sliding_piece.rb'

class Rook < SlidingPiece
  def move_dirs
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end
end
