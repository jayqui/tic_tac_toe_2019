require_relative "spec_helper"
require_relative "../app/services/board_state.rb"

RSpec.describe BoardState do
  subject { described_class.new(board: board, whose_turn_piece: "X") }

  let(:board) do
    [
      "O", nil, "X",
      "X", nil, nil,
      "X", "O", "O",
    ]
  end

  it "finds three children" do
    expect(subject.children.count).to eq(3)
  end

  it "fills the children in in the right place" do
    expect(subject.children[0].board[1]).to eq("X") # .X1
    expect(subject.children[1].board[4]).to eq("X") # .X4
    expect(subject.children[2].board[5]).to eq("X") # .X5
  end

  it "non-end-state children have children of their own" do
    expect(subject.children[0].children).not_to be_empty
    expect(subject.children[2].children).not_to be_empty
  end

  it "end-state children do not have children of their own" do
    expect(subject.children[1].children).to be_empty # .X4
  end

  it "gives scores to end-state children" do
    expect(subject.children[1].score_for_x).to eq(10)
    expect(subject.children[1].score_for_o).to eq(-10)
  end

  it "leaves nil scores for end-state children" do
    expect(subject.children[0].score_for_x).to eq(nil)
    expect(subject.children[0].score_for_o).to eq(nil)
  end

  describe "when stalemate is inevitable" do
    let(:board) do
      [
        "O", nil, "X",
        "X", "X", "O",
        "O", nil, "X",
      ]
    end

    it "finds two children" do
      expect(subject.children.count).to eq(2)
    end

    it "gives scores to end-state descendants" do
      expect(subject.children[0].score_for_x).to eq(nil)
      expect(subject.children[0].score_for_o).to eq(nil)
      expect(subject.children[1].score_for_x).to eq(nil)
      expect(subject.children[1].score_for_o).to eq(nil)
    end

    it "leaves nil scores for end-state descendants" do
      expect(subject.children[0].children[0].score_for_x).to eq(0) # .X1.O7
      expect(subject.children[1].children[0].score_for_x).to eq(0) # .X7.O1
    end
  end
end
