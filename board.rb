require_relative 'pawn.rb'
require_relative 'king.rb'
require_relative 'queen.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'rook.rb'
require_relative 'errors.rb'

require 'byebug'

class Board
  def initialize(board = nil)
    if board.nil?
      @board = grid
      initialize_board
    else
      @board = board
    end
  end

  def grid
    Array.new(8) { Array.new(8) { nil } }
  end

  def move(start, end_pos)
    raise NoPieceAtPosition if self[start].nil?
    piece = self[start]
    if piece.moves.include?(end_pos)
      raise MoveIntoCheck if piece.move_into_check?(end_pos)
      piece.pos = end_pos
      update_position_piece(end_pos, piece)
      update_position_piece(start, nil)
      update_pieces_board
    else
      raise OccupiedSpace
    end
  end

  def each_piece(&prc)
    @board.flatten.compact.each do |piece|
      prc.call(piece)
    end
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
      pieces = []
      each_piece do |piece|
        pieces << piece if piece.color == color
      end
      pieces.any? do |piece|
        piece.moves.any? do |move|
          !piece.move_into_check?(move)
        end
      end
    else
      false
    end
  end

  def display
    @board.each do |row|
      row.each do |spot|
        print spot ? spot.symbol + " " : "_ "
      end
      print "\n"
    end
    nil
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def update_position_piece(pos, piece)
    @board[pos[0]][pos[1]] = piece
  end

  def inspect
  end

  def row(i)
    @board[i]
  end

  def dup
    board_dup = grid
    each_piece do |piece|
      board_dup[piece.pos[0]][piece.pos[1]] =
      piece.class.new(piece.color, piece.pos.dup, piece.symbol)
    end
    duplicate = Board.new(board_dup)
    duplicate.update_pieces_board
    duplicate
  end

  def move!(start, end_pos)
    piece = self[start]
    piece.pos = end_pos
    update_position_piece(end_pos, piece)
    update_position_piece(start, nil)
    update_pieces_board
  end

  def opponent_piece?(pos, color)
    self[pos].color != color
  end

  def update_pieces_board
    each_piece do |piece|
      piece.update_board(self)
    end
  end

  def opponent_pieces(color)
    opp_pieces = []
    each_piece do |piece|
      opp_pieces << piece if piece.color != color
    end
    opp_pieces
  end

  private

  def initialize_board
    initialize_pawns
    initialize_rooks
    initialize_bishops
    initialize_knights
    initialize_kings
    initialize_queens
    update_pieces_board
  end

  def initialize_pawns
    @board[1].each_index do |i|
      @board[1][i] = Pawn.new(:black, [1,i], "\u265F")
    end
    @board[6].each_index do |i|
      @board[6][i] = Pawn.new(:white, [6,i], "\u2659")
    end
  end

  def initialize_rooks
    @board[0][0] = Rook.new(:black, [0,0], "\u265C")
    @board[0][7] = Rook.new(:black, [0,7], "\u265C")
    @board[7][0] = Rook.new(:white, [7,0], "\u2656")
    @board[7][7] = Rook.new(:white, [7,7], "\u2656")
  end

  def initialize_bishops
    @board[0][2] = Bishop.new(:black, [0,2], "\u265D")
    @board[0][5] = Bishop.new(:black, [0,5], "\u265D")
    @board[7][2] = Bishop.new(:white, [7,2], "\u2657")
    @board[7][5] = Bishop.new(:white, [7,5], "\u2657")
  end

  def initialize_knights
    @board[0][1] = Knight.new(:black, [0,1], "\u265E")
    @board[0][6] = Knight.new(:black, [0,6], "\u265E")
    @board[7][1] = Knight.new(:white, [7,1], "\u2658")
    @board[7][6] = Knight.new(:white, [7,6], "\u2658")
  end

  def initialize_kings
    @board[0][4] = King.new(:black, [0,4], "\u265A")
    @board[7][4] = King.new(:white, [7,4], "\u2654")
  end

  def initialize_queens
    @board[0][3] = Queen.new(:black, [0,3], "\u265B")
    @board[7][3] = Queen.new(:white, [7,3], "\u2655")
  end


end