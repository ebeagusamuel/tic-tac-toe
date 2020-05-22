require_relative '../lib/validators.rb'
require_relative '../lib/board.rb'
require_relative '../lib/player.rb'

describe Validators do
  curr_board = Board.new
  player = Player.new("sam", "X")
  move = 3

  describe '.validate_move?' do
    it 'should return true if move is available on the current board' do
      actual = Validators.validate_move?(curr_board.board, move)
      expect(actual).to be true
    end

     it 'should return false if move is not available on the current board' do
      curr_board.update_board(move, player)
      actual = Validators.validate_move?(curr_board.board, move)
      expect(actual).to be false
    end
  end

  describe '.won?' do
    it 'should return false if no winning combination is on the current board' do
      curr_board.update_board(move, player)
      actual = Validators.won?(curr_board.board, player)
      expect(actual).to be false
    end

    it 'should return true if a winning combination is on the current board' do
      curr_board.update_board(1, player)
      curr_board.update_board(2, player)
      actual = Validators.won?(curr_board.board, player)
      expect(actual).to be true
    end

     it 'should return true if a winning combination is on the current board' do
      curr_board.update_board(5, player)
      curr_board.update_board(7, player)
      actual = Validators.won?(curr_board.board, player)
      expect(actual).to be true
    end

    it 'should return false if no winning combination is on the current board' do
      curr_board.board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      curr_board.update_board(4, player)
      curr_board.update_board(8, player)
      actual = Validators.won?(curr_board.board, player)
      expect(actual).to be false
    end
  end

  describe '.draw?' do
    it 'should return false if all tiles are not full and no winning combination found' do
      curr_board.update_board(move, player)
      actual = Validators.draw?(curr_board.board, player)
      expect(actual).to be false
    end

    it 'should return true if all tiles are full and no winning combination found' do
      curr_board.board = %w[X X O O O X X O X]
      actual = Validators.draw?(curr_board.board, player)
      expect(actual).to be true
    end
  end
end
