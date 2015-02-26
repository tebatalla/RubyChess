require_relative 'pawn.rb'
require_relative 'king.rb'
require_relative 'queen.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'rook.rb'
require_relative 'errors.rb'

require 'byebug'

class Board
  def self.grid
    Array.new(8) { Array.new(8) { nil } }
  end

  def initialize(board = nil)
    if board.nil?
      @board = self.class.grid
      initialize_board
    else
      @board = board
    end
  end

  def move(start, end_pos)
    raise NoPieceAtPosition if self[start].nil?

    piece = self[start]
    if piece.moves.include?(end_pos)
      raise MoveIntoCheck if piece.move_into_check?(end_pos)
      piece.pos = end_pos
      self[end_pos] = piece
      self[start] = nil
    elsif self[end_pos]
      raise OccupiedSpace
    else
      raise InvalidMove
    end
  end

  def each_piece(&prc)
    all_pieces.each do |piece|
      prc.call(piece)
    end
  end

  def all_pieces
    @board.flatten.compact
  end

  def in_check?(color)
    king_position = []

    each_piece do |piece|
      if piece.is_a?(King) && piece.color == color
        king_position = piece.pos
      end
    end

    opponent_pieces(color).any? do |piece|
      piece.moves.include?(king_position)
    end
  end

  def checkmate?(color)
    if in_check?(color)
      pieces = all_pieces.select { |piece| piece.color == color }
      pieces.all? do |piece|
        piece.moves.all? do |move|
          piece.move_into_check?(move)
        end
      end
    else
      false
    end
  end

  def display
    puts "   a  b  c  d  e  f  g  h"
    i = 8
    tile = true
    @board.each do |row|
      print "#{i} "
      row.each do |spot|
        print (spot ? "\u2004" + spot.symbol.colorize(piece_color(spot.color)) + "\u2004" : "\u2004\u2003\u2004").colorize(tile_color(tile))
        tile = !tile
      end
      tile = !tile
      print " #{i}\n"
      i -= 1
    end
    puts "   a  b  c  d  e  f  g  h"
    nil
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @board[row][col] = value
  end

  def inspect
  end

  def dup
    board_dup = self.class.grid
    duplicate = Board.new(board_dup)
    each_piece do |piece|
      board_dup[piece.pos[0]][piece.pos[1]] =
      piece.class.new(piece.color, piece.pos.dup, piece.symbol, duplicate)
    end
    duplicate
  end

  def move!(start, end_pos)
    piece = self[start]
    piece.pos = end_pos
    self[end_pos] = piece
    self[start] = nil
  end

  def opponent_piece?(pos, color)
    return false if self[pos].nil?
    self[pos].color != color
  end

  def opponent_pieces(color)
    all_pieces.select { |piece| piece.color != color }
  end

  private

  def initialize_board
    initialize_pawns
    initialize_rooks
    initialize_bishops
    initialize_knights
    initialize_kings
    initialize_queens
  end

  def initialize_pawns
    @board[1].each_index do |i|
      @board[1][i] = Pawn.new(:black, [1,i], "\u265F", self)
    end
    @board[6].each_index do |i|
      @board[6][i] = Pawn.new(:white, [6,i], "\u265F", self)
    end
  end

  def initialize_rooks
    @board[0][0] = Rook.new(:black, [0,0], "\u265C", self)
    @board[0][7] = Rook.new(:black, [0,7], "\u265C", self)
    @board[7][0] = Rook.new(:white, [7,0], "\u265C", self)
    @board[7][7] = Rook.new(:white, [7,7], "\u265C", self)
  end

  def initialize_bishops
    @board[0][2] = Bishop.new(:black, [0,2], "\u265D", self)
    @board[0][5] = Bishop.new(:black, [0,5], "\u265D", self)
    @board[7][2] = Bishop.new(:white, [7,2], "\u265D", self)
    @board[7][5] = Bishop.new(:white, [7,5], "\u265D", self)
  end

  def initialize_knights
    @board[0][1] = Knight.new(:black, [0,1], "\u265E", self)
    @board[0][6] = Knight.new(:black, [0,6], "\u265E", self)
    @board[7][1] = Knight.new(:white, [7,1], "\u265E", self)
    @board[7][6] = Knight.new(:white, [7,6], "\u265E", self)
  end

  def initialize_kings
    @board[0][4] = King.new(:black, [0,4], "\u265A", self)
    @board[7][4] = King.new(:white, [7,4], "\u265A", self)
  end

  def initialize_queens
    @board[0][3] = Queen.new(:black, [0,3], "\u265B", self)
    @board[7][3] = Queen.new(:white, [7,3], "\u265B", self)
  end

  def tile_color(toggle)
    return { background: toggle ? :red : :blue }
  end

  def piece_color(color)
    return { color: color == :black ? :black : :white }
  end
end
