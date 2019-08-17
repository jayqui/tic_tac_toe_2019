module CliSequences
  def say_welcome
    puts "Welcome to Tic Tac Toe!"
  end

  def request_player_info(piece)
    puts "\nShould player #{piece} be Human (H) or AI? (A)"
    print "> "
    h_or_a = gets.chomp&.[](0)&.downcase
    while !%w[h a].include?(h_or_a)
      puts "Please enter H for human or A for AI."
      print "> "
      h_or_a = gets.chomp
    end

    # puts "\nWhat is the name for Player #{piece}?"
    # print "> "
    # player_name = gets.chomp

    player_name = h_or_a == "h" ? "Human" : "Computer"

    puts "Welcome, #{player_name}!"

    { name: player_name, is_human: h_or_a == "h" }
  end

  def request_placement_index
    placement_index = gets.chomp
    while invalid_input?(placement_index)
      input_errors.each_value { |error_message| say_bad_input(error_message) }
      placement_index = gets.chomp
    end

    placement_index
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

  def say_draw
    puts "It's a draw!"
  end

  def say_winner(name_or_identifier)
    puts "#{name_or_identifier} wins!"
  end
end
