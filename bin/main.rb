#!/usr/bin/env ruby
puts 'Welcome to the Tic Tac Toe Game'
puts 'Player 1, please choose your symbol to use in the game...'
PLAYER_ONE_SYMBOL = gets.chomp
puts "Player 1 will use #{PLAYER_ONE_SYMBOL}"

puts 'Player 2, please choose your symbol to use in the game...'
PLAYER_TWO_SYMBOL = gets.chomp
puts "Player 2 will use #{PLAYER_TWO_SYMBOL}"

board_array = %w[1 2 3 4 5 6 7 8 9]

def display_board(board_array)
  puts " #{board_array[0]} | #{board_array[1]} | #{board_array[2]} "
  puts '-----------'
  puts " #{board_array[3]} | #{board_array[4]} | #{board_array[5]} "
  puts '-----------'
  puts " #{board_array[6]} | #{board_array[7]} | #{board_array[8]} "
end

display_board(board_array)
