require 'byebug'
require './board'
require 'colorize'
require './player'
class Game

  attr_accessor :board, :sides


  def initialize
    @board = Board.starting_board
  end

  def play
    player1 = Player.new(:white)
    player2 = Player.new(:black)
    players = [player1, player2]

    loop do
      begin
        render
        move = players.first.take_turn
        board.move(*move, players.first.color)
      rescue ChessError => e
        puts "#{e.message}\n".colorize(color: :red)
        retry
      end

      if board.checkmate?(players.last.color)
        render
        puts "Checkmate! #{players.first.color.capitalize} wins."
        exit
      end
      players.rotate!
    end
  end

  def render
    grid = @board.render
    deltas = [0, 1]
    grid.each_with_index do |row, yidx|
      row_string = " #{8 - yidx} ".colorize(color: :green)
      row.each_with_index do |tile, xidx|
        if (xidx + deltas.first).even?
          background = :gray
        else
          background = :white
        end
          row_string << tile.colorize(background: background)
      end
      deltas.rotate!
      puts row_string
    end
    puts "    a  b  c  d  e  f  g  h".colorize(color: :green)
  end
end

class InvalidInputError < ChessError
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play

end
