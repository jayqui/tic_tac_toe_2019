class EndStateChecker
  attr_reader :board, :piece

  def initialize(board)
    @board = board
  end

  def win?(piece)
    @piece = piece

    nw_se_diagonal_win? ||
    ne_sw_diagonal_win? ||
    vertical_win? ||
    horizontal_win?
  end

  def draw?
    return false if win?("X") || win?("O")
    board.each { |square| return false if square.nil? }
    true
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
