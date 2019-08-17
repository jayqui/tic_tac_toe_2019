require_relative "services/a_i_move_chooser.rb" # seems necessary for testing . . .
require_relative "services/cli_sequences.rb" # seems necessary for testing . . .
require_relative "services/end_state_checker.rb" # seems necessary for testing . . .
require_relative "services/input_validator.rb" # seems necessary for testing . . .

class Game
  include CliSequences

  attr_reader :x_player, :o_player
  attr_accessor :board, :input_errors, :whose_turn

  def initialize(x_player:, o_player:)
    @board = Array.new(9)
    @x_player = x_player
    @o_player = o_player
    @whose_turn = @x_player
    @input_errors = {}
  end

  def play_game
    while !game_over?
      turn
      self.whose_turn = whose_turn == x_player ? o_player : x_player
    end
    display_end_state
  end

  def display_end_state
    say_draw if cats_game?
    say_winner(x_player.piece) if win?(x_player.piece)
    say_winner(o_player.piece) if win?(o_player.piece)
    say_print_board(board)
  end

  def game_over?
    cats_game? || win?(x_player.piece) || win?(o_player.piece)
  end

  def win?(piece)
    EndStateChecker.new(board).win?(piece)
  end

  def cats_game?
    EndStateChecker.new(board).draw?
  end

  def turn
    say_take_turn("#{whose_turn.piece} (#{whose_turn.name})", board)

    if whose_turn.human?
      placement_index = request_placement_index
    else
      placement_index = AIMoveChooser.call(board: board, protagonist_piece: whose_turn.piece)
    end

    place(placement_index.to_i)
  end

  def invalid_input?(placement_index)
    !InputValidator.valid_placement_index?(self, placement_index)
  end

  def place(board_index)
    board[board_index] = whose_turn.piece
  end
end
