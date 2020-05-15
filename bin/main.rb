#!/usr/bin/env ruby
def welcome
  puts 'Welcome to the Tic Tac Toe Game'
end

def get_player1_symbol(symbol = nil)
  puts 'Player 1, please choose your symbol to use in the game...'
  player_one_symbol = gets.chomp
  puts "Player 1 will use #{player_one_symbol}"
  return player_one_symbol
end

def get_player2_symbol(player_one_symbol)
  puts 'Player 2, please choose your symbol to use in the game...'
  player_two_symbol = gets.chomp
  if player_one_symbol == player_two_symbol
    puts 'Symbol chosen already'
    get_player2_symbol(player_one_symbol)
  else
    puts "Player 2 will use #{player_two_symbol}"
  end
end

# board_array = %w[1 2 3 4 5 6 7 8 9]

# def display_board(board_array)
#   puts " #{board_array[0]} | #{board_array[1]} | #{board_array[2]} "
#   puts '-----------'
#   puts " #{board_array[3]} | #{board_array[4]} | #{board_array[5]} "
#   puts '-----------'
#   puts " #{board_array[6]} | #{board_array[7]} | #{board_array[8]} "
# end

# display_board(board_array)

# puts 'Game begins'
# puts 'Player 1, your turn'
# puts 'Player 2, your turn'

# puts 'Player 1 wins'
# puts 'Player 2 wins'

# puts 'Game ends'
welcome
# get_player1_symbol
player1_symbol = get_player1_symbol
get_player2_symbol(player1_symbol)
