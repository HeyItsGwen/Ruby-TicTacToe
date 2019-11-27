#!/usr/bin/env ruby

require './lib/gamelogic.rb'

# frozen_string_literal: true

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
