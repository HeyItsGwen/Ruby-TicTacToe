# frozen_string_literal: true

require './lib/gamelogic.rb'

RSpec.describe '#initialize' do
  before(:each) do
    @game = TicTacToe.new
  end

  it 'should initialize the board with array of spaces and set variables' do
    expect(@game.board[0...9]).to eq([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
  end

  it "shouldn't initialize the board with an empty array" do
    expect(@game.board[0...8]).not_to eq(['', '', '', '', '', '', '', '', ''])
  end

  it "should set the 'player' variable to 'x'" do
    expect(@game.player).to eq('x')
  end

  it "shouldn't set the 'player' variable to 'o'" do
    expect(@game.player).not_to eq('o')
  end
end

RSpec.describe '#check_win_aux' do
  before(:each) do
    @game = TicTacToe.new
  end

  it 'should not declare a winner with an empty board' do
    @game.board[0...2] = [' ', ' ', ' ']
    expect(@game.check_win_aux([0, 1, 2])).to eq(nil)
  end

  it 'should declare a winner if a row of 3 is passed' do
    @game.board[0...2] = %w[x x x]
    expect(@game.check_win_aux([0, 1, 2])).to eq('x')
  end

  it 'should not declare winner without a row of 3' do
    @game.board[0...2] = %w[x o x]
    expect(@game.check_win_aux([0, 1, 2])).to eq(nil)
  end
end

RSpec.describe '#check_win' do
  before(:each) do
    @game = TicTacToe.new
  end

  it "should make return 'has_winner' (nil with no input)" do
    expect(@game.check_win).to eq(nil)
  end

  it 'should win if there are 3 in a row vertically' do
    @game2 = TicTacToe.new
    @game2.board[0...9] = %w[x o o x o o x o o]
    expect(@game2.check_win).to eq('x')
    expect(@game2.check_win).not_to eq(nil)
    expect(@game2.check_win).not_to eq('o')
  end

  it 'should win if there are 3 in a row horizontally' do
    @game3 = TicTacToe.new
    @game3.board[0...9] = %w[o o o x x x x x x]
    expect(@game3.check_win).to eq('o')
    expect(@game3.check_win).not_to eq(nil)
    expect(@game3.check_win).not_to eq('x')
  end

  it 'should win if are 3 in a row diagonally' do
    @game4 = TicTacToe.new
    @game4.board[0...9] = %w[x o o o x o o o x]
    expect(@game4.check_win).to eq('x')
    expect(@game4.check_win).not_to eq(nil)
    expect(@game4.check_win).not_to eq('o')
  end
end

RSpec.describe '#make_move' do
  before(:each) do
    @game = TicTacToe.new
    @game.board[0...9] = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  it 'should allow a move is params are positive and <=9' do
    expect(@game.make_move(1)).to eq(true)
  end

  it 'should not allow a move with negative or > 9 params' do
    expect(@game.make_move(10)).to eq(false)
    expect(@game.make_move(-5)).to eq(false)
  end

  it 'should allow a move only if the space is empty' do
    @game.board[0...9] = [' ', 'x', ' ', ' ', ' ', ' ', ' ', ' ', ' ']

    expect(@game.make_move(1)).to eq(true)
    expect(@game.make_move(2)).to eq(false)
  end
end
