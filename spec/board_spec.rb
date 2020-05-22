require_relative '../lib/board.rb'

describe Board do
  describe '#integer_count' do
    it 'returns true if return value is an integer or nil' do
      board = Board.new
      count = board.integer_count
      expect(count).to be_a Integer || Nil
    end
  end

  describe '#update_board' do
    it 'should return true if board is updated' do
      curr_board = Board.new
      player = Player.new('chris', 'O')
      player_move = 5
      curr_board.update_board(player_move, player)
      expect(curr_board.board[4]).to eql('O')
    end
  end
end
