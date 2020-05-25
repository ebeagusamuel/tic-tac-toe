require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

describe Player do
  let(:player_one) { Player.new('sam', 'X') }
  let(:player_two) { Player.new('chris', 'O') }
  let(:curr_board) { Board.new }

  describe '.player_turn' do
    it 'should return true if the player_turn method returns an instance of player one' do
      test_player = Player.player_turn(player_one, player_two, curr_board)
      expect(test_player).to be player_one
    end

    it 'returns true if the player_turn method returns an instance of player
     two after player one makes a move' do
      curr_board.update_board(4, player_one)
      test_player = Player.player_turn(player_one, player_two, curr_board)
      expect(test_player).to be player_two
    end
  end
end
