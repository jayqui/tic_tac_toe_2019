class AIMoveChooser
  def self.call(board:, protagonist_piece:)
    new(board: board, protagonist_piece: protagonist_piece).choose_square
  end

  attr_reader :board, :protagonist_piece

  PROTAGONIST_WINS = 10
  NOBODY_WINS = 0
  ANTAGONIST_WINS = -10

  def initialize(board:, protagonist_piece:)
    @board = board
    @protagonist_piece = protagonist_piece
  end

  def choose_square
    # choose_random
  end

  private

  def antagonist_piece
    protagonist_piece == "X" ? "O" : "X"
  end

  def choose_random
    empty_indices.sample
  end

  def empty_indices
    board.each_index.select { |idx| board[idx].nil? }
  end
end
