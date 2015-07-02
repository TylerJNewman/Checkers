require_relative 'board'
class Game

  def initialize
    @board = Board.new
    @players = [:black, :red]
  end

  def play
    puts @board.render
    until @board.over?
     

      from_pos, *next_positions = get_moves
      move(from_pos, next_positions)
      puts b.render
    end
    puts b.render
    puts "Game over"
  end

  def current_player
    @players.first
  end

  def get_moves
    positions = []

    positions << get_pos
    next_pos = get_pos
    until next_pos.emtpy?
      positions << next_pos
    end

    positions
  end

  def get_pos
    gets.chomp.split(",").map(&:to_i)
  end

  def move(from_pos, next_positions)
  end


end

game = Game.new
game.play