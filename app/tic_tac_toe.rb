require 'pry'

require_relative "player.rb"
require_relative "services/cli_sequences.rb"
require_relative "services/input_validator.rb"
require_relative "services/win_checker.rb"

class TicTacToe
  include CliSequences

  attr_reader :p1, :p2
  attr_accessor :board, :input_errors, :whose_turn

  def initialize(p1_name:, p2_name:)
    @board = Array.new(9)
    @p1 = Player.new(name: p1_name, piece: "X")
    @p2 = Player.new(name: p2_name, piece: "O")
    @whose_turn = @p1
    @input_errors = {}
  end

  def self.start
    intro_sequence
  end

  def self.intro_sequence
    new(p1_name: '', p2_name: '').play_game
  end

  def play_game
    say_welcome

    while !game_over?
      turn
      self.whose_turn = whose_turn == p1 ? p2 : p1
    end
    display_end_state
  end

  def display_end_state
    say_draw if cats_game?
    say_winner(p1.piece) if win?(p1.piece)
    say_winner(p2.piece) if win?(p2.piece)
    say_print_board(board)
  end

  def game_over?
    cats_game? || win?(p1.piece) || win?(p2.piece)
  end

  def win?(piece)
    WinChecker.call(board: board, piece: piece)
  end

  def cats_game?
    return false if win?(p1.piece) || win?(p2.piece)
    board.each { |square| return false if square.nil? }
    true
  end

  def turn
    say_take_turn(whose_turn.piece, board)

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
