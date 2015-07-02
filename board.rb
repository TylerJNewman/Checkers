require_relative 'piece'
require 'byebug'

class Board

  attr_accessor :rows

  def initialize(fill_board = true)
    make_grid(fill_board)
  end

  def [](pos)
    raise 'invalid pos' unless valid_pos?(pos)
    r, c = pos
    @rows[r][c]
  end

  def []=(pos, piece)
    raise 'invalid pos' unless valid_pos?(pos)
    r, c = pos
    @rows[r][c] = piece
  end

  def add_piece(piece, pos)
    # raise 'position not empty' unless empty?(pos)

    self[pos] = piece
  end

  def win?
    #other player can't move
  end

  def lose?
  end

  def quit?
  end

  def over?
    win? || lose? || quit?
  end

  def dup
    new_board = Board.new(false)

    pieces.each do |piece|
      piece.class.new(piece.color, new_board, piece.pos)
    end

    new_board
  end

  def empty?(pos)
    self[pos].nil?
  end

  def possible_jump?
    #check diagonal jumps
  end

  def move_piece(turn_color, array_of_pos)
    first_pos = array_of_pos.shift

    raise 'from position is empty' if empty?(first_pos)

    second_pos = array_of_pos.shift
    piece = self[first_pos]

    if piece.color != turn_color
      raise 'not your piece'
    elsif !piece.moves.include?(second_pos)
      raise 'piece cannot move like that'
    end

    move_piece!(first_pos, second_pos)
  end

  def move_piece!(from_pos, to_pos)
    piece = self[from_pos]

    self[to_pos] = piece
    self[from_pos] = nil
    piece.pos = to_pos

    nil
  end

  def pieces
    @rows.flatten.compact
  end

  def render
    puts
    print "  "

    (0..7).map { |i| print "#{i} " }

    puts

    @rows.each_with_index.map do |row, i|
      print "#{i } "

      row.map do |piece|
        if piece.nil?
         print '. '
        else
          print piece.render
        end
      end

      puts
    end

  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def make_grid(fill_board)
    @rows = Array.new(8) { Array.new(8) }
    return unless fill_board
    [:black, :white].each do |color|
      fill_row(color)
      fill_row(color)
    end
  end

  def fill_row(color)
    i = (color == :black) ? 0 : 5
    3.times do |row|
      8.times do |col|
        create_piece(color, [row + i,col]) unless (col + row) % 2 == 0
      end
    end

  end


  def create_piece(color, pos)
    Piece.new(color, self, pos)
  end

end

