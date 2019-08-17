class AIMoveChooser
  def self.call(game:, protagonist_piece:)
    new(game: game, protagonist_piece: protagonist_piece).choose_square
  end

  attr_reader :game, :protagonist_piece

  PROTAGONIST_WINS = 10
  NOBODY_WINS = 0
  ANTAGONIST_WINS = -10

  def initialize(game:, protagonist_piece:)
    @game = game
    @protagonist_piece = protagonist_piece
  end

  def choose_square
    choose_random
  end

  private

  def board
    game.board
  end

  def simulate_move(index:, piece:)

  end

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
