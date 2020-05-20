class Player
  attr_reader :name, :symbol
  attr_accessor :num_of_wins

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @num_of_wins = 0
  end
end
