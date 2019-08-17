class Player
  attr_reader :piece, :name

  def initialize(piece:, name:, is_human:)
    @piece = piece
    @name = name == "" ? [*'a'..'z'].sample * 5 : name
    @is_human = is_human
  end
end
