require 'pry'

# TODO: require all in ./services
require_relative "player.rb"
# require_relative "services/cli_sequences.rb"
require_relative "services/input_validator.rb"
require_relative "services/win_checker.rb"

class TicTacToe
  # include CliSequences

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
    puts "Welcome to Tic Tac Toe!"
    new(p1_name: '', p2_name: '').play_game
  end

  def play_game
    while !game_over?
      turn
      self.whose_turn = whose_turn == p1 ? p2 : p1
    end
  end

  def game_over?
    cats_game? || win?(p1.piece) || win?(p2.piece)
  end

  def win?(piece)
    WinChecker.call(board: board, piece: piece)
  end

  def cats_game?
    board.each { |square| return false if square.nil? }
    true
  end

  def turn
    puts "\n#{whose_turn.piece}'s turn!"
    print_board

    puts "name a square for the next piece, 0-8:"
    print "> "

    placement_index = gets.chomp

    while invalid_input?(placement_index)
      input_errors.each_value { |error_message| puts error_message }
      print "> "
      placement_index = gets.chomp
    end

    place(whose_turn.piece, placement_index.to_i)
  end

  def invalid_input?(placement_index)
    !InputValidator.valid_placement_index?(self, placement_index)
  end

  def print_board
    board.
      map { |square| square.nil? ? "_" : square }.
      each_slice(3) { |row| puts "\t" + row.join(" ") }
    puts
  end

  def place(player_piece, board_index)
    board[board_index] = player_piece
  end
end
