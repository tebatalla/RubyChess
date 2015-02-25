require_relative 'stepping_piece.rb'

class Knight < SteppingPiece
  def move_dirs
    [
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1],
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2]
    ]
  end
end
