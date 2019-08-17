require_relative "game.rb"
require_relative "player.rb"
require_relative "services/cli_sequences.rb" # why necessary?

class TicTacToe
  include CliSequences

  def start
    say_welcome

    x_info = request_player_info("X")
    o_info = request_player_info("O")

    x_player = Player.new(name: x_info[:name], is_human: x_info[:is_human], piece: "X")
    o_player = Player.new(name: o_info[:name], is_human: o_info[:is_human], piece: "O")

    Game.new(x_player: x_player, o_player: o_player).play_game
  end
end
