class Validators
  @winning_combinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]
  def initialize; end

  def self.validate_move?(board, move)
    board.include?(move)
  end

  def self.won?(board, player)
    @winning_combinations.each do |arr|
      return true if board[arr[0]] == player.symbol && board[arr[1]] == player.symbol && board[arr[2]] == player.symbol
    end
    false
  end

  def self.draw?(board, player)
    count = board.count { |item| item.is_a? Integer }
    count.zero? && !won?(board, player) ? true : false
  end
end
