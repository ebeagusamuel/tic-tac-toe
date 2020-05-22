require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

describe Player do
  describe '.player_turn' do
    it 'should return true if it is an instance of a the Player class' do
      player_one = Player.new('sam', 'X')
      player_two = Player.new('chris', 'O')
      curr_board = Board.new
      test_player = Player.player_turn(player_one, player_two, curr_board)
      expect(test_player).to be_a(Player)
    end
  end
end
