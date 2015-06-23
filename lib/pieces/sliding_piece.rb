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
