require 'pry'

require_relative "player.rb"
require_relative "services/cli_sequences.rb"
require_relative "services/input_validator.rb"
require_relative "services/win_checker.rb"

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
    WinChecker.call(board: board, piece: piece)
  end

  def cats_game?
    return false if win?(x_player.piece) || win?(o_player.piece)
    board.each { |square| return false if square.nil? }
    true
  end

  def turn
    say_take_turn("#{whose_turn.piece} (#{whose_turn.name})", board)

    placement_index = gets.chomp
    while invalid_input?(placement_index)
      input_errors.each_value { |error_message| say_bad_input(error_message) }
      placement_index = gets.chomp
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
