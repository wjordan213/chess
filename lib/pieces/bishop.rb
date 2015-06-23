# encoding: utf-8
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
