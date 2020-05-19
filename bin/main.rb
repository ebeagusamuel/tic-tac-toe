#!/usr/bin/env ruby

require './lib/player.rb'
require './lib/board.rb'
require './lib/validators.rb'

user_symbols = %w[X O]

def welcome
  puts '-----------------------------------'
  puts '| Welcome to the Tic Tac Toe Game |'
  puts '-----------------------------------'
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

def play_game(curr_board, player1, player2, player)
  loop do
    player = Player.player_turn(player1, player2, curr_board)
    move = Player.player_move
    if Validators.validate_move?(curr_board.board, move)
      curr_board.update_board(move, player)
      curr_board.display_board
    else
      puts 'Invalid move. Please try again...'
      curr_board.display_board
      play_game(curr_board, player1, player2, player)
    end
    break if Validators.won?(curr_board.board, player) || Validators.draw?(curr_board.board, player)
  end
  game_over(curr_board.board, player1, player2, player)
end

def game_over(board, player1, player2, player)
  if Validators.won?(board, player)
    puts "*****#{player.name} has won the game!*****"
    player.num_of_wins += 1
  end
  puts 'The game is a draw!' if Validators.draw?(board, player)
  puts "If you want to play again press 'Y'"
  answer = gets.chomp.downcase
  if answer != 'y'
    puts 'Ending game now!'
    puts "#{player1.name} has won #{player1.num_of_wins} time(s)."
    puts "#{player2.name} has won #{player2.num_of_wins} time(s)."
  else
    curr_board = Board.new
    puts 'Starting new game ...'
    curr_board.display_board
    play_game(curr_board, player1, player2, player)
  end
end

welcome
player1 = get_player1_name(user_symbols)
player2 = get_player2_name(user_symbols)
start_game
curr_board = Board.new
player = Player.player_turn(player1, player2, curr_board)
curr_board.display_board
play_game(curr_board, player1, player2, player)
