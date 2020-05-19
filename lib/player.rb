class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def player_move
    puts 'Choose a number between 1 and 9...'
    move = gets.chomp.to_i
    if move.zero?
      puts 'You chose an invalid number, please choose again ...'
      player_move
    else
      move
    end
  end

end
