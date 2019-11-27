# frozen_string_literal: true

class TicTacToe
  attr_reader :board, :player

  def initialize
    @board = Array.new(9)
    @filled = 0
    board.each_with_index { |_x, index| board[index] = ' ' }
    @player = 'x'
  end

  def board_full
    @filled == 9
  end

  def check_win_aux(arr)
    has_winner = nil

    x = 0
    o = 0
    arr.each do |i|
      x += 1 if @board[i] == 'x'
      o += 1 if @board[i] == 'o'
    end

    has_winner = 'x' if x == 3
    has_winner = 'o' if o == 3

    has_winner
  end

  def check_win
    has_winner = nil

    lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [2, 4, 6], [0, 4, 8]]

    lines.each do |line|
      check = check_win_aux(line)
      has_winner = check unless check.nil?
      break if has_winner
    end

    has_winner
  end

  def make_move(square)
    return false unless square.positive? && square <= 9

    index = square - 1
    if @board[index] == ' '
      @board[index] = @player
      @player = @player == 'x' ? 'o' : 'x'
      @filled += 1
      true
    else
      false
    end
  end
end
