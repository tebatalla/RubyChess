require_relative 'board.rb'
require_relative 'player.rb'

class Game
  attr_reader :board

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @player1.color = :white
    @player2.color = :black
    @current_player = @player1
  end

  def play
    until checkmate?
      display_board
      user_in_check_message if user_in_check?
      begin
        move = @current_player.play_turn
        if @board[move.first] && @board[move.first].color != @current_player.color
          raise NotPlayersPiece
        end
        @board.move(move.first, move.last)
      rescue NoPieceAtPosition => e
        puts "No piece at that starting position."
        retry
      rescue OccupiedSpace => e
        puts "That ending position is currently occupied."
        retry
      rescue MoveIntoCheck => e
        puts "That move puts you into check."
        retry
      rescue InvalidMove => e
        puts "That is an invalid move."
        retry
      rescue NotPlayersPiece => e
        puts "That is not your piece."
        retry
      end
      toggle_player unless checkmate?
    end
    display_board
    victory
  end

  private

  def user_in_check?
    @board.in_check?(@current_player.color)
  end

  def display_board
    system "clear"
    @board.display
  end

  def user_in_check_message
    puts "You are in check."
  end

  def toggle_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def checkmate?
    @board.checkmate?(:black) || @board.checkmate?(:white)
  end

  def victory
    puts "#{@current_player.name}, you win!"
  end
end

if __FILE__ == $PROGRAM_NAME
  player_one = Player.new(ARGV[0] || "Player 1")
  player_two = Player.new(ARGV[1] || "Player 2")
  ARGV.clear
  game = Game.new player_one, player_two
  game.play
end
