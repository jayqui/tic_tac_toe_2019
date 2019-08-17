class AIMoveChooser
  def self.call(board:, protagonist_piece:)
    new(board: board, protagonist_piece: protagonist_piece).choose_square
  end

  attr_reader :board, :protagonist_piece

  def initialize(board:, protagonist_piece:)
    @board = board
    @protagonist_piece = protagonist_piece
  end

  def choose_square
    choose_random
  end

  private

  def choose_random
    board.each_index.select { |idx| board[idx].nil? }.sample
  end
end
