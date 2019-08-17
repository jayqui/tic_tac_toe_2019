class Player
  attr_reader :piece, :name

  def initialize(piece:, name:)
    @piece = piece
    @name = name == "" ? [*'a'..'z'].sample * 5 : name
  end
end
