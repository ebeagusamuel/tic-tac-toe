#!/usr/bin/env ruby
user_symbols = %w[X O]
board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def welcome
  puts 'Welcome to the Tic Tac Toe Game'
end

def get_player1_name(user_symbols)
  puts 'Player 1, what is your name...'
  player_one_name = gets.chomp
  puts "#{player_one_name} will use #{user_symbols[0]}"
  player_one_name
end

def get_player2_name(user_symbols)
  puts 'Player 2, what is your name...'
  player_two_name = gets.chomp
  puts "#{player_two_name} will use #{user_symbols[1]}"
  player_two_name
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

def player_turn(board, player_one_name, player_two_name, user_symbols)
  item_count = board.count { |item| item.is_a? Integer }
  if item_count.even?
    puts "#{player_two_name}, it is your turn..."
    { 'name' => player_two_name.to_s, 'sign' => (user_symbols[1]).to_s }
  else
    puts "#{player_one_name}, it is your turn..."
    { 'name' => player_one_name.to_s, 'sign' => (user_symbols[0]).to_s }
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

def validate_move?(board, player_move)
  board.include?(player_move)
end

def update_board(board, player_move, player)
  if validate_move?(board, player_move)
    board[player_move - 1] = player['sign']
    display_board(board)
  else
    puts 'Invalid move. Please try again...'
    player_move
  end
end

def won?(board, player)
  winning_combinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]
  winning_combinations.each do |arr|
    return true if board[arr[0]] == player['sign'] && board[arr[1]] == player['sign'] && board[arr[2]] == player['sign']
  end
  false
end

def draw?(board, player)
  count = board.count { |item| item.is_a? Integer }
  count.zero? && !won?(board, player) ? true : false
end

def play_game(board, player1_name, player2_name, player, user_symbols)
  loop do
    player = player_turn(board, player1_name, player2_name, user_symbols)
    move = player_move
    update_board(board, move, player)
    break if won?(board, player) || draw?(board, player)
  end
  game_over(board, player1_name, player2_name, player, user_symbols)
end

def game_over(board, player1_name, player2_name, player, user_symbols)
  puts "#{player['name']} has won the game!" if won?(board, player)
  puts 'The game is a draw!' if draw?(board, player)
  puts "If you want to play again press 'Y'"
  answer = gets.chomp.downcase
  return puts 'Ending game now!' unless answer == 'y'

  board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  display_board(board)
  play_game(board, player1_name, player2_name, player, user_symbols)
end

welcome
player1_name = get_player1_name(user_symbols)
player2_name = get_player2_name(user_symbols)
start_game
player = player_turn(board, player1_name, player2_name, user_symbols)
display_board(board)
play_game(board, player1_name, player2_name, player, user_symbols)
