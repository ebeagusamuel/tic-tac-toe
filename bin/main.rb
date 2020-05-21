#!/usr/bin/env ruby

require_relative '../lib/player.rb'
require_relative '../lib/board.rb'
require_relative '../lib/validators.rb'

user_symbols = %w[X O]

def welcome
  puts '-----------------------------------'
  puts '| Welcome to the Tic Tac Toe Game |'
  puts '-----------------------------------'
end

def get_players(user_symbols)
  puts "Player 1, what is your name..."
  player_one_name = gets.chomp
  player_one = Player.new(player_one_name, user_symbols[0])
  puts "#{player_one.name} will use #{player_one.symbol}"

  puts "Player 2, what is your name..."
  player_two_name = gets.chomp
  player_two = Player.new(player_two_name, user_symbols[1])
  puts "#{player_two.name} will use #{player_two.symbol}"

  { 'player1' => player_one, 'player2' => player_two }
end

def player_turn(player_one, player_two, curr_board)
  count = curr_board.integer_count
  if count.even?
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
    player = player_turn(player1, player2, curr_board)
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

players = get_players(user_symbols)
player1 = players['player1']
player2 = players['player2']
start_game
curr_board = Board.new
player = player_turn(player1, player2, curr_board)
display_board(curr_board.board)
play_game(curr_board, player1, player2, player)
