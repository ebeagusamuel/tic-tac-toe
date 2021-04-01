class Player
  attr_reader :name, :symbol
  attr_accessor :num_of_wins

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @num_of_wins = 0
  end

  def self.player_turn(player_one, player_two, curr_board)
    count = curr_board.integer_count
    if count.even?
      player_two
    else
      player_one
    end
  end

  #comment
end
