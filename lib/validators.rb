class Validators

  def initialize; end

  def self.validate_move?(board, move)
    board.include?(move)
  end
end
