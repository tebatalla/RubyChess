require_relative 'stepping_piece.rb'

class King < SteppingPiece
  def move_dirs
    moves = [
      [0,1],
      [0,-1],
      [1,0],
      [-1,0],
      [1,1],
      [-1,-1],
      [1,-1],
      [-1,1]
    ]
    moves
  end
end
