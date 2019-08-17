class TicTacToe
  def self.play
    new()
  end

  attr_accessor :board

  def initialize
    @board = Array.new(9)
    @p1 = Player.new()
    @p2 = Player.new()
  end
end
