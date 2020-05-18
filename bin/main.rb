#!/usr/bin/env ruby
user_symbols = %w[X O]
board_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def welcome
  puts 'Welcome to the Tic Tac Toe Game'
end

def get_player1_name(user_symbols)
  puts 'Player 1, what is your name...'
  player_one_name = gets.chomp
  puts "#{player_one_name} will use #{user_symbols[0]}"
  return player_one_name
end

def get_player2_name(user_symbols)
  puts 'Player 2, what is your name...'
  player_two_name = gets.chomp
  puts "#{player_two_name} will use #{user_symbols[1]}"
  return player_two_name
end

def start_game
  puts "Let the game begin"
end

def display_board(board_array)
  puts "Current board: "
  puts " #{board_array[0]} | #{board_array[1]} | #{board_array[2]} "
  puts '-----------'
  puts " #{board_array[3]} | #{board_array[4]} | #{board_array[5]} "
  puts '-----------'
  puts " #{board_array[6]} | #{board_array[7]} | #{board_array[8]} "
end

def player_turn(board_array, player_one_name, player_two_name, user_symbols)
  item_count = board_array.count { |item| item.is_a? Integer }
  if item_count % 2 == 0
    puts "#{player_two_name}, it is your turn..."
    player_two = {"name" => "#{player_two_name}", "sign" => "#{user_symbols[1]}" }
  else
    puts "#{player_one_name}, it is your turn..."
    player_one = {"name" => "#{player_one_name}", "sign" => "#{user_symbols[0]}" }
  end
end

def player_move
  puts "Choose a number between 1 and 9..."
  move = gets.chomp.to_i
  if move == 0 
    puts "You chose an invalid number, please choose again ..." 
    player_move
  else
    move
  end
end

def validate_move?(board_array, player_move)
  board_array.include?(player_move)
end

def update_board(board_array, player_move, player)
  if validate_move?(board_array, player_move)
    board_array[player_move-1] = player["sign"]
    display_board(board_array)
  else
    puts "Invalid move. Please try again..."
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
    return true if board[arr[0]] == player["sign"] && board[arr[1]] == player["sign"] && board[arr[2]] == player["sign"]
  end
  false
end

def draw?(board_array)
  count = board_array.count { |item| item.is_a? Integer }
  count == 0 && !won?(board, player) ? true : false
end

def play_game(board_array, player1_name, player2_name, player, user_symbols)
  loop do
    display_board(board_array)
    player = player_turn(board_array, player1_name, player2_name, user_symbols)
    move = player_move
    update_board(board_array, move, player)
    break if won?(board_array, player) || draw?(board_array)
  end
end

def game_over(board, player)
  if won?(board, player)
    puts "#{player["name"]} has won the game!"
  elsif draw?(board, player)
    puts "The game is a draw!"
  end
  puts "Do you want to play again?(Y/N)"
  answer = gets.chomp.downcase
  if answer == "y"
    board_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end
end

welcome
player1_name = get_player1_name(user_symbols)
player2_name = get_player2_name(user_symbols)
start_game
player = player_turn(board_array, player1_name, player2_name, user_symbols)
play_game(board_array, player1_name, player2_name, player, user_symbols)

  
