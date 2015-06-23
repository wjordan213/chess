# encoding: utf-8
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
    if @board.open_space?(one_forward)
      one_forward
    else
      []
    end
  end

  def two_forward
    two_forward = [location[0] + 2 * @move_dirs[color], location[1]]
    if @board.open_space?(two_forward)
      two_forward
    else
      []
    end
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
