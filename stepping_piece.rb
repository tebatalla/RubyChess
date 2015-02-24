require_relative 'piece.rb'

class SteppingPiece < Piece
  def moves
    possible_moves = []
    move_dirs.each do |move_dir|
      possible_move = [@pos[0] + move_dir[0], @pos[1] + move_dir[1]]
      unless end_of_board?(possible_move) || @board[possible_move]
        possible_moves << possible_move
      end
    end
    possible_moves
  end

end
