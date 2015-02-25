require_relative 'board.rb'

class Game

  MOVE_MAP = {
      "a" => 0,
      "b" => 1,
      "c" => 2,
      "d" => 3,
      "e" => 4,
      "f" => 5,
      "g" => 6,
      "h" => 7,
      "8" => 0,
      "7" => 1,
      "6" => 2,
      "5" => 3,
      "4" => 4,
      "3" => 5,
      "2" => 6,
      "1" => 7
    }

  def initialize
    @board = Board.new
    @current_player = :white
  end

  def play
    until checkmate?
      display_board
      user_in_check_message if user_in_check?
      begin
        # move parsing logic into player class
        move = prompt_move(@current_player)
        parsed_move = parse_move(move)
        if @board[parsed_move.first] && @board[parsed_move.first].color != @current_player
          raise NotPlayersPiece
        end
        @board.move(parsed_move.first, parsed_move.last)
      rescue NoPieceAtPosition => e
        puts "No piece at that starting position"
        retry
      rescue OccupiedSpace => e
        puts "That ending position is currently occupied."
        retry
      rescue MoveIntoCheck => e
        puts "That move puts you into check."
        retry
      rescue NotPlayersPiece => e
        puts "That is not your piece."
        retry
      end
      toggle_player unless checkmate?
    end
    display_board
    victory(@current_player)
  end

  private

  def user_in_check?
    @board.in_check?(@current_player)
  end

  def display_board
    system "clear"
    @board.display
  end

  def user_in_check_message
    puts "You are in check."
  end

  def toggle_player
    @current_player = @current_player == :white ? :black : :white
  end

  def checkmate?
    @board.checkmate?(:black) || @board.checkmate?(:white)
  end

  def prompt_move(player)
    puts "#{player}, make your move"
    gets.chomp
  end

  def parse_move(move)
    # f2,f3
    # [6,5],[5,5]
    start, ending = move.split(',')
    # f2
    start_move = [MOVE_MAP[start[1]], MOVE_MAP[start[0]]]
    ending_move = [MOVE_MAP[ending[1]], MOVE_MAP[ending[0]]]
    [start_move, ending_move]
  end

  def victory(player)
    puts "#{player}, you win!"
  end
end
