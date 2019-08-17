class InputValidator
  def self.valid_placement_index?(game, placement_index)
    new(game, placement_index).valid_placement_index?
  end

  def board
    game.board
  end

  attr_reader :game, :placement_index

  def initialize(game, placement_index)
    @game = game
    @placement_index = placement_index
  end

  def valid_placement_index?
    validate_placement_index
    game.input_errors.none?
  end

  private

  def square_taken?
    return false unless ("0".."8").include?(placement_index)
    !board[placement_index.to_i].nil?
  end

  def ill_formed_input?
    !("0".."8").include?(placement_index)
  end

  def validate_placement_index
    game.input_errors = {}
    possible_input_errors.each do |error_key, message|
      game.input_errors[error_key] = message if send("#{error_key}?")
    end
  end

  def possible_input_errors
    {
      ill_formed_input: "Must be a number from 0-8",
      square_taken: "Square is already taken",
    }
  end
end
