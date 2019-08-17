require 'pry'

# TODO: require all in ./services
require_relative "player.rb"
require_relative "services/intro_sequence.rb"

class TicTacToe
  # include CliSequences

  attr_reader :p1, :p2
  attr_accessor :board, :whose_turn

  def initialize(p1_name:, p2_name:)
    @board = Array.new(9)
    @p1 = Player.new(name: p1_name, piece: "X")
    @p2 = Player.new(name: p2_name, piece: "O")
    @whose_turn = @p1
  end

  def self.start
    intro_sequence
  end

  def self.intro_sequence
    puts "Welcome to Tic Tac Toe!"
    new(p1_name: '', p2_name: '').play_game
  end

  def play_game
    while game_not_over?
      turn
      self.whose_turn = whose_turn == p1 ? p2 : p1
    end
  end

  def game_not_over?
    !game_over?
  end

  def game_over?
    cats_game?
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
    while !("0".."8").include?(placement_index)
      puts "Must be a number from 0-8, silly!"
      print "> "
      placement_index = gets.chomp
    end

    while board[placement_index.to_i]
      puts "Square is already taken. Try again . . ."
      print "> "
      placement_index = gets.chomp
    end

    place(whose_turn.piece, placement_index.to_i)
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
