class Piece
  def initialize(color, position)
    @color, @position = color, position
  end

  def moves
    raise "Moves method not implemented"
  end
end
