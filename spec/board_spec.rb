require_relative '../lib/board.rb'

describe Board do
  let(:curr_board) { Board.new }
  describe '#integer_count' do
    it 'returns true when there are integer values in the board' do
      count = curr_board.integer_count
      expect(count).to be > 0
    end

    it 'returns false when there are no integer values in the board' do
      curr_board.board = %w[X O X O X O O O X]
      count = curr_board.integer_count
      expect(count).to eql(0)
    end
  end

  describe '#update_board' do
    it 'returns true if board is updated with player symbol after a player move' do
      player = Player.new('chris', 'O')
      player_move = 5
      curr_board.update_board(player_move, player)
      expect(curr_board.board[4]).to eql('O')
    end

    it 'returns false if board is not updated with player symbol after a player move' do
      player = Player.new('chris', 'O')
      player_move = 10
      curr_board.update_board(player_move, player)
      expect(curr_board.board[4]).to_not eql('O')
    end
  end
end
