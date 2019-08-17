class TicTacToe
  attr_accessor :board, :p1, :p2

  def initialize(p1_name:, p2_name:)
    @board = Array.new(9)
    @p1 = Player.new(name: p1_name, piece: "X")
    @p2 = Player.new(name: p2_name, piece: "O")
  end

  def self.play
    intro_sequence

    puts "eyy"
    # new()
  end

  def self.intro_sequence
    puts "Welcome to Tic Tac Toe!"
    puts "\nWhat is the name for Player X?"
    print "> "
    p1_name = gets.chomp
    puts "Welcome, #{p1_name}!"

    puts "\nWhat is the name for Player O?"
    print "> "
    p2_name = gets.chomp
    puts "Welcome, #{p2_name}!"

    puts "\nLet's do this!"
    puts "\nHere's the board:"
  end

  def print_board
    board.
      map { |square| square.nil? ? "_" : square }.
      each_slice(3) { |row| puts "\t" + row.join(" ") }
  end

  def place(board_index:, player_piece:)
    # return unless board[board_index].nil? # TODO
    board[board_index] = player_piece
  end
end
