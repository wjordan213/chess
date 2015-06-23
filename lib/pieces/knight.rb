# encoding: utf-8
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
