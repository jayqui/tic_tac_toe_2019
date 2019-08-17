require_relative "spec_helper"
require_relative "../app/services/a_i_move_chooser.rb"

RSpec.describe AIMoveChooser do
  subject { described_class.new(board: board, piece: "X") }


end
