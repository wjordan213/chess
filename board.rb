load './pieces.rb'
load './individual_pieces.rb'

class Board
  POSITIONS = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  attr_accessor :board

  def self.starting_board
    board = Board.new
    board.populate
    board
  end

  def self.within_bounds?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def populate
    POSITIONS.each_with_index do |piece, col|
      board[0][col] = piece.new(:black, [0, col], self)
      board[1][col] = Pawn.new(:black, [1, col], self)
      board[7][col] = piece.new(:white, [7, col], self)
      board[6][col] = Pawn.new(:white, [6, col], self)
    end

  end

  def []=(pos, mark)
    board[pos[0]][pos[1]] = mark
  end

  def [](pos)
    return nil if board[pos[0]].nil?
    board[pos[0]][pos[1]]
  end

  def inspect
    render
  end

  def move(origin, dest, color)
    square = self[origin]

    raise InvalidMoveError, "No piece at your chosen square." if square.nil?
    raise InvalidInputError, "Thats not your piece!" if square.color != color
    raise InvalidMoveError, "Not a valid move." unless square.valid_moves.include?(dest)

    move!(origin, dest)
  end

  def move!(origin, dest)
    self[origin].move(dest)
  end

  def render
    board.map do |row|
      row.map { |square| square ? " #{square.render} " : '   ' }
    end
  end

  def update_position(piece, location)
    self[location] = piece
  end

  def open_space?(pos)
    self[pos].nil? && pos.all? { |coord| coord.between?(0, 7) }
  end

  def dup
    board_dup = Board.new
    board.each_with_index do |row, ri|
      row.each_with_index do |el, ci|
        if el.nil?
          board_dup[[ri, ci]] = nil
        else
          new_piece = el.class.new(el.color, el.location, board_dup)
          board_dup[[ri, ci]] = new_piece
        end
      end
    end
    board_dup
  end

  def checkmate?(color)
    return false unless in_check?(color)
    colored_pieces(color).any? { |piece| piece.valid_moves.any? }
  end

  def in_check?(color)
    king = find_king(color)

    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king.location)
    end
  end

  private

  def pieces
    board.flatten.compact
  end

  def colored_pieces(color)
    pieces.select { |piece| piece.color == color }
  end

  def find_king(color)
    pieces.find { |piece| piece.is_a?(King) && piece.color == color }
  end

end
