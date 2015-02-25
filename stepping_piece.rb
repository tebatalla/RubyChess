require_relative 'piece.rb'

class SteppingPiece < Piece
  def moves
    possible_moves = []
    move_dirs.each do |move_dir|
      possible_move = [@pos[0] + move_dir[0], @pos[1] + move_dir[1]]
      possible_moves << possible_move if valid_move?(possible_move)
    end
    possible_moves
  end
end
