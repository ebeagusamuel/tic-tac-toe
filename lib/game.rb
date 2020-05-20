class Game
  def initialize; end

  def self.player_turn(player_one, player_two, curr_board)
    item_count = curr_board.integer_count

    if item_count.even?
      puts "#{player_two.name}, it is your turn..."
      player_two
    else
      puts "#{player_one.name}, it is your turn..."
      player_one
    end
  end

  def self.player_move
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
