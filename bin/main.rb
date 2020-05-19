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

def player_turn(player_one, player_two)
  item_count = Board.integer_count

  if item_count.even?
    puts "#{player_two.name}, it is your turn..."
    player_one
  else
    puts "#{player_one.name}, it is your turn..."
    player_two
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



# def update_board(board, player_move, player)
#   if validate_move?(board, player_move)
#     board[player_move - 1] = player['sign']
#     display_board(board)
#   else
#     puts 'Invalid move. Please try again...'
#     player_move
#   end
# end

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

# def play_game( player1, player2, player)
#   loop do
#     player = player_turn(player1, player2)
#     move = player_move
#     update_board(board, move, player)
#     break if won?(board, player) || draw?(board, player)
#   end
#   game_over(board, player1_name, player2_name, player, user_symbols)
# end

def play_game(board, player1, player2, player)
  loop do
    player = player_turn(player1, player2)
    move = player_move
    if Validators.validate_move?(board.return_board, move)
      board.update_board(move, player)
      board.display_board
    else
      puts 'Invalid move. Please try again...'
      player_move
    end
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

player1 = get_player1_name(user_symbols)
player2 = get_player2_name(user_symbols)

start_game

player = player_turn(player1, player2)

board = Board.new
board.display_board

play_game(board, player1, player2, player)

# play_game(board, player1_name, player2_name, player, user_symbols)







  # game_over(board, player1_name, player2_name, player, user_symbols)

