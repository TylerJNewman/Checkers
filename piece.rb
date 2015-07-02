class Piece

  SYMBOLS = { black: 'B ', white: 'R ' }

  attr_accessor :color, :pos, :king


  def initialize(color, board, pos, king = false)
    @color = color
    @board = board
    @pos = pos
    @king = false

    board.add_piece(self, pos)
  end

  def render
    SYMBOLS[color]
  end

  def perform_slide
    true
  end

  def perform_jump
    true
  end

  def maybe_promote
    #check if color reach opposite row...
    #black starts at 0, so opposite row would be 7

  end

  def move_dir?
    #step if piece
    #daig if king
  end


end
