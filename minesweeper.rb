require_relative 'board'

class Minesweeper

  attr_accessor :board

  WINNING_NUM = 69

  def initialize(player)
    @board = Board.new
    @player = player
    @showing = 0
  end

  def play
    board.populate
    play_turn until game_over?
    if won?
      puts "Congrats #{@player}, you won!"
    else
      puts "Sorry you lost!"
    end
    puts board.render
  end

  def play_turn
    puts board.render
    if want_to_flag?
      begin
        pos = get_pos
      end while board[pos].showed || !board.in_range?(pos)
      board[pos].flagged = !board[pos].flagged
    else
      begin
        pos = get_pos
      end while board[pos].showed || !board.in_range?(pos) || board[pos].flagged
        spread(pos)
    end
  end

  def want_to_flag?
    puts "Would you like to flag or unflag a position? (y/n)"
    gets.chomp == "y"
  end

  def get_pos
    puts "Enter a position ex. 3,4"
    gets.chomp.split(/\D+/).map(&:to_i)
  end

  def spread(pos)
    return if board[pos].flagged
    if board[pos].value >= 1 || board[pos].showed
      @showing += 1 unless board[pos].showed
      board[pos].showed = true
      return
    else
      @showing += 1 unless board[pos].showed
      board[pos].showed = true
      ranged_positions = board.surrounding_positions(pos).select { |tile| board.in_range?(tile) }
      ranged_positions.each do |ranged_pos|
        spread(ranged_pos)
      end
    end
  end

  def game_over?
    won? || lost?
  end

  def won?
    @showing == WINNING_NUM
  end

  def lost?
    board.render.include?("M")
  end

end

game = Minesweeper.new("Joseph")

game.play
