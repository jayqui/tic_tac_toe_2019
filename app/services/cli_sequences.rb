module CliSequences
  def intro_sequence
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
end
