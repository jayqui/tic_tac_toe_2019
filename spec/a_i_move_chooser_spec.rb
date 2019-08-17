require_relative "spec_helper"
# require_relative "../app/game.rb"
# require_relative "../app/services/a_i_move_chooser.rb"

RSpec.describe AIMoveChooser do
  let(:x_player) { Player.new() }
  let(:game) do
    g = Game.new(x_player: x_player, o_player: o_player)
    g.board = board
    g
  end

  subject do
    described_class.new(game: game, protagonist_piece: "X")
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
      expect(subject.send :choose_move).to eq(4)
    end
  end
end
