require_relative 'sliding_piece.rb'

class Queen < SlidingPiece
  def move_dirs
    [
      [1, 1], [-1, -1], [1, -1], [-1, 1],
      [0, 1], [0, -1], [1, 0], [-1, 0]
    ]
  end
end
