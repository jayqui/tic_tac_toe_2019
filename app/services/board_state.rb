require_relative "end_state_checker.rb"

class BoardState
  attr_reader :board, :descriptor, :score_for_o, :score_for_x, :whose_turn_piece
  attr_accessor :children

  def initialize(board:, whose_turn_piece:, descriptor: "")
    @board = board
    @whose_turn_piece = whose_turn_piece
    @descriptor = descriptor
    @children = []
    @score_for_x = nil
    @score_for_o = nil
    build_tree
  end

  def build_tree
    if cats_game?
      @score_for_x = 0
      @score_for_o = 0
    end

    empty_indices.each do |index|
      hypotethical_board = board.dup
      hypotethical_board[index] = whose_turn_piece
      next_turn_piece = whose_turn_piece == "X" ? "O" : "X"

      if win?("X")
        @score_for_x = 10
        @score_for_o = -10
      elsif win?("O")
        @score_for_x = -10
        @score_for_o = 10
      else
        self.children << BoardState.new(
          board: hypotethical_board,
          whose_turn_piece: next_turn_piece,
          descriptor: descriptor + ".#{whose_turn_piece}#{index}"
        )
      end
    end

    # TEMP
    # print_board

    self
  end

  def win?(piece)
    EndStateChecker.new(board).win?(piece)
  end

  def cats_game?
    EndStateChecker.new(board).draw?
  end

  def empty_indices
    board.each_index.select { |idx| board[idx].nil? }
  end

  # TEMP
  def print_board
    puts descriptor
    puts "score_for_x: #{score_for_x}"
    puts "score_for_o: #{score_for_o}"

    board.
      map { |square| square.nil? ? "_" : square }.
      each_slice(3) { |row| puts "\t" + row.join(" ") }
    puts
  end
end
