require_relative 'piece.rb'

class Pawn < Piece

  def moves
    possible_moves = []

    possible_move = [@pos[0].send(direction, 1), @pos[1]]
    unless end_of_board?(possible_move) || @board[possible_move]
      possible_moves << possible_move
    end

    if (pos[0] == 1 && @color == :black) ||
      (pos[0] == 6 && @color == :white)
      possible_move =[@pos[0].send(direction, 2), @pos[1]]
      unless end_of_board?(possible_move) || @board[possible_move]
        possible_moves << possible_move
      end
    end

    attacking_moves.each do |attacking_move|
      possible_move = attacking_move
      if @board[possible_move] && @board.opponent_piece?(possible_move, @color)
        possible_moves << possible_move
      end
    end
    possible_moves
  end

  private

  def direction
    @color == :black ? :+ : :-
  end

  def attacking_moves
    [
      [@pos[0].send(direction, 1), @pos[1] + 1],
      [@pos[0].send(direction, 1), @pos[1] - 1]
    ]
  end
end
