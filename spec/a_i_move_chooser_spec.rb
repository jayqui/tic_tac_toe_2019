require_relative "spec_helper"
require_relative "../app/game.rb"
require_relative "../app/player.rb"
require_relative "../app/services/a_i_move_chooser.rb"

RSpec.describe AIMoveChooser do
  # let(:x_player) { Player.new(piece: "X", name: "XanderBot", is_human: false) }
  # let(:o_player) { Player.new(piece: "O", name: "Orville", is_human: true) }
  # let(:game) do
  #   g = Game.new(x_player: x_player, o_player: o_player)
  #   g.board = board
  #   g
  # end

  subject do
    # described_class.new(game: game, protagonist_piece: "X")
    described_class.new(board: board, protagonist_piece: "X")
  end

  describe "when the progagonist can immediately win" do
    let(:board) do
      [
        "O", nil, "X",
        "X", nil, nil,
        "X", "O", "O",
      ]
    end

    it "chooses the win" do
      expect(subject.send :choose_square).to eq(4)
    end
  end

  describe "when the antagonist can immediately win on the next turn" do
    let(:board) do
      [
        "O", "O", nil,
        nil, nil, "X",
        "X", "X", "O",
      ]
    end

    it "blocks the antagonist" do
      expect(subject.send :choose_square).to eq(4)
    end
  end
end
