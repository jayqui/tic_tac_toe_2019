class WinChecker
  def self.call(board:, piece:)
    new(board: board, piece: piece).win?
  end

  attr_reader :board, :piece

  def initialize(board:, piece:)
    @board = board
    @piece = piece
  end

  def win?
    nw_se_diagonal_win? ||
    ne_sw_diagonal_win? ||
    vertical_win? ||
    horizontal_win?
  end

  private

  def nw_se_diagonal_win?
    [0,4,8].all? { |n| board[n] == piece }
  end

  def ne_sw_diagonal_win?
    [2,4,6].all? { |n| board[n] == piece }
  end

  def vertical_win?
    [0,3,6].all? { |n| board[n] == piece } ||
    [1,4,7].all? { |n| board[n] == piece } ||
    [2,5,8].all? { |n| board[n] == piece }
  end

  def horizontal_win?
    [*0..2].all? { |n| board[n] == piece } ||
    [*3..5].all? { |n| board[n] == piece } ||
    [*6..8].all? { |n| board[n] == piece }
  end
end
