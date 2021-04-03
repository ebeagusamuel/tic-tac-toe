#!/usr/bin/env ruby

require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/validators'

user_symbols = %w[X O]
counter = 0

def welcome
  puts '-----------------------------------'
  puts '| Welcome to the Tic Tac Toe Game |'
  puts '-----------------------------------'
end

def get_player(counter, user_symbols)
  puts "Player #{counter + 1}, what is your name..."
  player_name = gets.chomp
  player_name == '' ? player_name = "Player #{counter + 1}" : player_name
  player = Player.new(player_name, user_symbols[counter])
  puts "#{player.name} will use #{player.symbol}"
  player
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

def start_game
  puts 'Let the game begin'
end

def display_board(board)
  puts 'Current board: '
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play_game(curr_board, player1, player2, player)
  loop do
    player = Player.player_turn(player1, player2, curr_board)
    puts "#{Player.player_turn(player1, player2, curr_board).name}, it is your turn..."

    move = player_move
    if Validators.validate_move?(curr_board.board, move)
      curr_board.update_board(move, player)
      display_board(curr_board.board)
    else
      puts 'Invalid move. Please try again...'
      display_board(curr_board.board)
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
    display_board(curr_board.board)
    play_game(curr_board, player1, player2, player)
  end
end

welcome
player1 = get_player(counter, user_symbols)
counter += 1
player2 = get_player(counter, user_symbols)
start_game
curr_board = Board.new
player = Player.player_turn(player1, player2, curr_board)
puts "#{Player.player_turn(player1, player2, curr_board).name}, it is your turn..."
display_board(curr_board.board)
play_game(curr_board, player1, player2, player)
