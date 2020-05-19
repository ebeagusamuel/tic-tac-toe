class Board

  @@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def display_board
    puts 'Current board: '
    puts " #{@@board[0]} | #{@@board[1]} | #{@@board[2]} "
    puts '-----------'
    puts " #{@@board[3]} | #{@@board[4]} | #{@@board[5]} "
    puts '-----------'
    puts " #{@@board[6]} | #{@@board[7]} | #{@@board[8]} "
  end

  def self.integer_count
    item_count = @@board.count { |item| item.is_a? Integer }
  end

  def update_board(player_move, player)
    @@board[player_move - 1] = player.symbol
  end

  def return_board
    @@board
  end



end
