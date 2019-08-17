class InputValidator
  def self.valid_placement_index?(tic_tac_toe, placement_index)
    new(tic_tac_toe, placement_index).valid_placement_index?
  end

  def board
    tic_tac_toe.board
  end

  attr_reader :tic_tac_toe, :placement_index

  def initialize(tic_tac_toe, placement_index)
    @tic_tac_toe = tic_tac_toe
    @placement_index = placement_index
  end

  def valid_placement_index?
    validate_placement_index
    tic_tac_toe.input_errors.none?
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
    tic_tac_toe.input_errors = {}
    possible_input_errors.each do |error_key, message|
      tic_tac_toe.input_errors[error_key] = message if send("#{error_key}?")
    end
  end

  def possible_input_errors
    {
      ill_formed_input: "Must be a number from 0-8",
      square_taken: "Square is already taken",
    }
  end
end
