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

    if whose_turn.human?
      placement_index = request_placement_index
    else
      placement_index = AIMoveChooser.call(game: self, protagonist_piece: whose_turn.piece)
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
