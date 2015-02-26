class Player
  attr_accessor :color
  attr_reader :name

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

  def initialize(name)
    @name = name
  end

  def play_turn
    puts "#{@name} (#{@color}), make a move"
    move = gets.chomp
    parse_move(move)
  end

  private

  def parse_move(move)
    start, ending = move.split(',')
    start_move = [MOVE_MAP[start[1]], MOVE_MAP[start[0]]]
    ending_move = [MOVE_MAP[ending[1]], MOVE_MAP[ending[0]]]
    [start_move, ending_move]
  end
end
