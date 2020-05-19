#!/usr/bin/env ruby

require './lib/player.rb'
require './lib/board.rb'
require './lib/validators.rb'

user_symbols = %w[X O]

def welcome
  puts 'Welcome to the Tic Tac Toe Game'
end

def get_player1_name(user_symbols)
  puts 'Player 1, what is your name...'
  player_one_name = gets.chomp
  player_one = Player.new(player_one_name, user_symbols[0])
  puts "#{player_one.name} will use #{player_one.symbol}"
  player_one
end

def get_player2_name(user_symbols)
  puts 'Player 2, what is your name...'
  player_two_name = gets.chomp
  player_two = Player.new(player_two_name, user_symbols[1])
  puts "#{player_two.name} will use #{player_two.symbol}"
  player_two
end

def start_game
  puts 'Let the game begin'
end

def player_turn(player_one, player_two, curr_board)
  item_count = curr_board.integer_count

  if item_count.even?
    puts "#{player_two.name}, it is your turn..."
    player_two
  else
    puts "#{player_one.name}, it is your turn..."
    player_one
  end
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

def play_game(curr_board, player1, player2, player)
  loop do
    player = player_turn(player1, player2, curr_board)
    move = player_move
    if Validators.validate_move?(curr_board.board, move)
      curr_board.update_board(move, player)
      curr_board.display_board
    else
      puts 'Invalid move. Please try again...'
      player_move
    end
    break if Validators.won?(curr_board.board, player) || Validators.draw?(curr_board.board, player)
  end
  game_over(curr_board.board, player1, player2, player)
end

def game_over(board, player1, player2, player)
  puts "#{player.name} has won the game!" if Validators.won?(board, player)
  puts 'The game is a draw!' if Validators.draw?(board, player)
  puts "If you want to play again press 'Y'"
  answer = gets.chomp.downcase
  return puts 'Ending game now!' unless answer == 'y'
  curr_board = Board.new
  puts "Starting new game ..."
  curr_board.display_board
  play_game(curr_board, player1, player2, player)
end

welcome
player1 = get_player1_name(user_symbols)
player2 = get_player2_name(user_symbols)
start_game
curr_board = Board.new
player = player_turn(player1, player2, curr_board)
curr_board.display_board
play_game(curr_board, player1, player2, player)
