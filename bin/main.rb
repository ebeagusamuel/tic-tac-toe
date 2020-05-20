#!/usr/bin/env ruby

require_relative '../lib/player.rb'
require_relative '../lib/board.rb'
require_relative '../lib/validators.rb'
require_relative '../lib/game.rb'

user_symbols = %w[X O]
counter = 0

def welcome
  puts '-----------------------------------'
  puts '| Welcome to the Tic Tac Toe Game |'
  puts '-----------------------------------'
end

def get_players(counter, user_symbols)
  puts "Player #{counter+1}, what is your name..."
  player_one_name = gets.chomp
  player_one = Player.new(player_one_name, user_symbols[0])
  puts "#{player_one.name} will use #{player_one.symbol}"
  counter += 1

  puts "Player #{counter+1}, what is your name..."
  player_two_name = gets.chomp
  player_two = Player.new(player_two_name, user_symbols[1])
  puts "#{player_two.name} will use #{player_two.symbol}"

  {"player1" => player_one, "player2" => player_two}
end

def start_game
  puts 'Let the game begin'
end

def play_game(curr_board, player1, player2, player)
  loop do
    player = Game.player_turn(player1, player2, curr_board)
    move = Game.player_move
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
  puts "If you want to play again press 'Y' or press any other key to end the game..."
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

players = get_players(counter, user_symbols)
player1 = players["player1"]
player2 = players["player2"]
start_game
curr_board = Board.new
player = Game.player_turn(player1, player2, curr_board)
curr_board.display_board
play_game(curr_board, player1, player2, player)
