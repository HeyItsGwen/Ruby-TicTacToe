#!/usr/bin/env ruby

# frozen_string_literal: true

class TicTacToe
  attr_reader :board, :player, :has_winner

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

def clear_screen
  80.times { || puts }
end

def show_game(game)
  puts '1  |2  |3  '
  puts " #{game.board[0]} | #{game.board[1]} | #{game.board[2]} "
  puts '---|---|---'
  puts '4  |5  |6  '
  puts " #{game.board[3]} | #{game.board[4]} | #{game.board[5]} "
  puts '---|---|---'
  puts '7  |8  |9  '
  puts " #{game.board[6]} | #{game.board[7]} | #{game.board[8]} "
end

# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
def play_game(game)
  winner = game.check_win
  valid_move = true
  while winner.nil? && !game.board_full
    clear_screen
    show_game(game)
    puts 'You dummy! That square is not valid!' unless valid_move
    print "Player '#{game.player}', which square (1 to 9, inclusive): "
    square = gets.chomp.to_i
    valid_move = game.make_move(square)
    winner = game.check_win
  end

  clear_screen
  show_game(game)
  if winner
    puts "Winner is '#{winner}'"
  else
    puts "It's a draw."
  end
end
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

tic_tac_toe = TicTacToe.new
play_game(tic_tac_toe)
