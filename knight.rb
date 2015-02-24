require_relative 'stepping_piece.rb'

class Knight < SteppingPiece
  def move_dirs
    moves = [
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1],
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2]
    ]
    moves
  end
end
