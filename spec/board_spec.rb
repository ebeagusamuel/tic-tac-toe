require_relative '../lib/board.rb'

describe Board do
    describe "#integer_count" do
        it "returns true if return value is an integer or nil" do
            board = Board.new
            count = board.integer_count
            expect(count).to be_a Integer || Nil
        end
    end
end