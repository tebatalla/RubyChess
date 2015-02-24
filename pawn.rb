require_relative 'piece.rb'

class Pawn < Piece

  def moves
    possible_moves = []

    possible_move = [@pos[0].send(direction, 1), @pos[1]]
    unless end_of_board?(possible_move) || @board[possible_move[0]][possible_move[1]]
      possible_moves << possible_move
    end

    if (@board[1].include?(self) && @color == :white) ||
      (@board[6].include?(self) && @color == :black)
      possible_move =[@pos[0].send(direction, 2), @pos[1]]
      unless end_of_board?(possible_move) || @board[possible_move[0]][possible_move[1]]
        possible_moves << possible_move
      end
    end

    attacking_moves.each do |attacking_move|
      possible_move = attacking_move
      if @board[possible_move[0]][possible_move[1]] && @board[possible_move].color != @color
        possible_moves << possible_move
      end
    end
    possible_moves
  end

  private

  def direction
    @color == :black ? :- : :+
  end

  def attacking_moves
    moves = [
      [@pos[0].send(direction, 1), @pos[1] + 1],
      [@pos[0].send(direction, 1), @pos[1] - 1]
    ]
    moves
  end
end
