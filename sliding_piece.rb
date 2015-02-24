require_relative 'piece.rb'
require 'byebug'

class SlidingPiece < Piece
  def moves
    possible_moves = []
    move_dirs.each do |move_dir|
      possible_move = [@pos[0] + move_dir[0], @pos[1] + move_dir[1]]
      until end_of_board?(possible_move) || @board[possible_move[0]][possible_move[1]]
        possible_moves << possible_move
        possible_move = [possible_move[0] + move_dir[0],
          possible_move[1] + move_dir[1]]
      end
    end
    possible_moves
  end
end
