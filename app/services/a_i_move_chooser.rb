require 'pry'
require_relative "end_state_checker.rb"

class AIMoveChooser
  def self.call(board:, protagonist_piece:)
    new(board: board, protagonist_piece: protagonist_piece).choose_square
  end

  attr_reader :board, :protagonist_piece

  PROTAGONIST_WINS = 10
  NOBODY_WINS = 0
  ANTAGONIST_WINS = -10

  def initialize(board:, protagonist_piece:)
    @original_board = board
    @board = board.dup
    @protagonist_piece = protagonist_piece
  end

  def choose_square
    # choose_random
    find_best_square
  end

  private

  def find_best_square
    # binding.pry

      puts "=== top of #find_best_square:"
      puts "=== protagonist_piece: #{protagonist_piece}"

    empty_indices.each do |index|
      puts "=== just inside #each:"
      puts "index: #{index}"
      puts "board: #{print_board}"

      board[index] = protagonist_piece # simulate move

      puts "=== after alteration of board:"
      puts "board: #{print_board}"
      puts

      return index if win?(protagonist_piece)

      AIMoveChooser.call(board: board, protagonist_piece: antagonist_piece)
    end

    # binding.pry

    # raise "shouldn't get here..."
    choose_random
  end

  def win?(piece)
    EndStateChecker.new(board).win?(piece)
  end

  def cats_game?
    EndStateChecker.new(board).draw?
  end

  # def simulate_move(index:, piece:)
  #   board[index] = piece
  # end

  # TEMP
  def print_board
    board.
      map { |square| square.nil? ? "_" : square }.
      each_slice(3) { |row| puts "\t" + row.join(" ") }
    puts
  end

  def antagonist_piece
    protagonist_piece == "X" ? "O" : "X"
  end

  def choose_random
    empty_indices.sample
  end

  def empty_indices
    board.each_index.select { |idx| board[idx].nil? }
  end
end
