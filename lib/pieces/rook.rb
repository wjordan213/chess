# encoding: utf-8
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
