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
