class Board
  attr_accessor :board

  def initialize
    # @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @board = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
  end

  def integer_count
    board.count { |item| item.is_a? Integer }
  end

  def update_board(player_move, player)
    board[player_move - 1] = player.symbol
  end
end
