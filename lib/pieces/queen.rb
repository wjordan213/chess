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
