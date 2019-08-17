require_relative "spec_helper"
require_relative "../app/services/win_checker.rb"

RSpec.describe WinChecker do
  subject { described_class.new(board: board, piece: "X") }

  describe "#nw_se_diagonal_win?" do
    context "when there is a NW-SE victory for the piece" do
      let(:board) do
        [
          "X", nil, nil,
          nil, "X", nil,
          nil, nil, "X",
        ]
      end

      it "returns true" do
        expect(subject.send :nw_se_diagonal_win?).to eq(true)
      end
    end

    context "when there is not a NW-SE victory for the piece" do
      let(:board) do
        [
          "X", nil, nil,
          nil, "X", nil,
          nil, nil, "O",
        ]
      end

      it "returns true" do
        expect(subject.send :nw_se_diagonal_win?).to eq(false)
      end
    end
  end

  describe "#ne_sw_diagonal_win?" do
    context "when there is a NE-SW victory for the piece" do
      let(:board) do
        [
          nil, nil, "X",
          nil, "X", nil,
          "X", nil, nil,
        ]
      end

      it "returns true" do
        expect(subject.send :ne_sw_diagonal_win?).to eq(true)
      end
    end

    context "when there is not a NE-SW victory for the piece" do
      let(:board) do
        [
          nil, nil, "O",
          nil, "X", nil,
          "X", nil, nil,
        ]
      end

      it "returns true" do
        expect(subject.send :ne_sw_diagonal_win?).to eq(false)
      end
    end
  end

  describe "#horizontal_win?" do
    context "when there is a horizontal victory for the piece" do
      let(:board) do
        [
          "X", "X", "X",
          nil, "X", nil,
          "X", nil, nil,
        ]
      end

      it "returns true" do
        expect(subject.send :horizontal_win?).to eq(true)
      end
    end

    context "when there is not a horizontal victory for the piece" do
      let(:board) do
        [
          "X", "X", "O",
          nil, "X", nil,
          "X", nil, nil,
        ]
      end

      it "returns true" do
        expect(subject.send :horizontal_win?).to eq(false)
      end
    end
  end
end
