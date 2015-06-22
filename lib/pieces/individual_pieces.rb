# encoding: utf-8
class Queen < SlidingPiece
  def initialize(color, location, board)
    super
    @move_dirs = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1],
      [1, 0],
      [-1, 0],
      [0, 1],
      [0, -1]
    ]
  end

  def render
    color == :white ? "\u2655" : "\u265B"
  end
end

class Bishop < SlidingPiece
  def initialize(color, location, board)
    super
    @move_dirs = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
  end

  def render
    color == :white ? "\u2657" : "\u265D"
  end
end

class Rook < SlidingPiece
  def initialize(color, location, board)
    super
    @move_dirs = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
  end

  def render
    color == :white ? "\u2656" : "\u265C"
  end
end

class King < SteppingPiece
  def initialize(color, location, board)
    super
    @move_dirs = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1],
      [1, 0],
      [-1, 0],
      [0, 1],
      [0, -1]
    ]
  end

  def render
    color == :white ? "\u2654" : "\u265A"
  end
end

class Knight < SteppingPiece
  def initialize(color, location, board)
    super
    @move_dirs = [
      [2, 1],
      [2,-1],
      [-2, 1],
      [-2, -1],
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2]
    ]
  end

  def render
    color == :white ? "\u2658" : "\u265E"
  end
end



class Pawn < Piece
  def initialize(color, location, board)
    super
    @move_dirs = { :white => -1, :black => 1 }
    @first_move = true
  end

  def move(dest)
    super
    @first_move = false
  end

  def render
    color == :white ? "\u2659" : "\u265F"
  end

  def moves
    forwards + diagonals
  end

  private

  def first_move?
    @first_move
  end

  def forwards
    if one_forward.any?
      [one_forward, two_forward]
    else
      []
    end
  end

  def one_forward
    one_forward = [location[0] + @move_dirs[color], location[1]]
    return one_forward if @board.open_space?(one_forward)
    []
  end

  def two_forward
    two_forward = [location[0] + 2 * @move_dirs[color], location[1]]
    return two_forward if @board.open_space?(two_forward)
    []
  end

  def diagonals
    diagonals = add_all_diagonals
    possible(diagonals)
  end

  def add_all_diagonals
    deltas = [-1, 1]
    deltas.map { |dir| [location[0] + @move_dirs[color], location[1] + dir] }
  end

  def possible(diagonals)
    diagonals.keep_if do |location|
      Board.within_bounds?(location) && self.enemy?(@board[location])
    end
  end
end
