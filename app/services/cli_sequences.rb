module CliSequences
  def say_welcome
    puts "Welcome to Tic Tac Toe!"
  end

  def say_draw
    puts "It's a draw!"
  end

  def say_winner(name_or_identifier)
    puts "#{name_or_identifier} wins!"
  end

  def say_print_board(board)
    board.
      map { |square| square.nil? ? "_" : square }.
      each_slice(3) { |row| puts "\t" + row.join(" ") }
    puts
  end

  def say_take_turn(name_or_identifier, board)
    puts "\n#{name_or_identifier}'s turn!"
    say_print_board(board)

    puts "name a square for the next piece, 0-8:"
    print "> "
  end

  def say_bad_input(error_message)
    puts error_message
    print "> "
  end
end
