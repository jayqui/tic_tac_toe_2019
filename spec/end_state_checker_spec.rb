require_relative "spec_helper"
require_relative "../app/services/end_state_checker.rb"

RSpec.describe EndStateChecker do
  subject do
    esc = described_class.new(board)
    esc.instance_variable_set(:@piece, "X")
    esc
  end

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
        expect(subject.send(:nw_se_diagonal_win?)).to eq(true)
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
        expect(subject.send(:nw_se_diagonal_win?)).to eq(false)
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
        expect(subject.send(:ne_sw_diagonal_win?)).to eq(true)
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
        expect(subject.send(:ne_sw_diagonal_win?)).to eq(false)
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
        expect(subject.send(:horizontal_win?)).to eq(true)
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
        expect(subject.send(:horizontal_win?)).to eq(false)
      end
    end
  end
end
