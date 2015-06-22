
class Piece
  attr_accessor :location
  attr_reader :color # Protected reader

  def self.next_square(location, delta)
    location.each_with_index.map { |el, idx| el + delta[idx] }
  end

  def initialize(color, location, board)
    @color = color
    @location = location
    @board = board
    @board.update_position(self, location)
  end

  def move(new_loc)
    if moves.include?(new_loc)
      @board.update_position(self, new_loc)
      @board.update_position(nil, self.location)
      self.location = new_loc
    else
      raise InvalidMoveError, "Can't move to that space."
    end
  end

  def valid_moves
    moves.delete_if { |pos| move_into_check?(pos) }
  end

  def move_into_check?(pos)
    board_dup = @board.dup
    board_dup.move!(self.location, pos)
    board_dup.in_check?(self.color)
  end

  protected

  def enemy?(other)
    return nil if other.nil?
    self.color != other.color
  end

  def moves
    raise NotImplementedError
  end

  private

  def valid_move?(location)
    @board.open_space?(location) || self.enemy?(@board[location])
  end

end

class SlidingPiece < Piece

  def initialize(color, location, board)
    super(color, location, board)
  end

  def moves
    possible_moves = []
    @move_dirs.each do |move_dir|
      new_loc = Piece.next_square(location, move_dir)

      while @board.open_space?(new_loc)
        possible_moves << new_loc
        new_loc = Piece.next_square(new_loc, move_dir)
      end

      possible_moves << new_loc if self.enemy?(@board[new_loc])

    end
    possible_moves
  end
end

class SteppingPiece < Piece
  def initialize(color, location, board)
    super
  end

  def moves
    @move_dirs.map do |move_dir|
      Piece.next_square(location, move_dir)
    end.keep_if do |pos|
      @board.open_space?(pos) || self.enemy?(@board[pos])
    end
  end
end

class ChessError < StandardError
end

class InvalidMoveError < ChessError
end
