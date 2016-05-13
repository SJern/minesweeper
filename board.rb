require_relative 'tile'
# require 'byebug'

class Board
  attr_reader :grid

  NUMBER_OF_MINES = 12

  def initialize
    @grid = Array.new(9) { Array.new(9) {Tile.new} }
  end

  def render
    grid.map { |row|
      row.map { |tile|
        if tile.flagged
          "F"
        elsif tile.showed
          if tile.mine
            "M"
          elsif tile.value > 0
            tile.value
          else
            "_"
          end
        else
          "#"
        end

      }.join(' ')
     }.join("\n")
  end

  def populate
    success = 0
    until success == NUMBER_OF_MINES
      pos = random_pos
      if self[pos].mine == false
        self[pos].mine = true
        ranged_positions = surrounding_positions(pos).select { |tile| in_range?(tile) }
        ranged_positions.each do |pos|
          self[pos].increment_val
        end
        success += 1
      end
    end
  end

  def surrounding_positions(pos)
    y, x = pos

    [
      [y-1, x-1],
      [y-1, x],
      [y-1, x+1],
      [y, x-1],
      [y, x+1],
      [y+1, x-1],
      [y+1, x],
      [y+1, x+1]
    ]
  end

  def random_pos
    [rand(grid.length-1), rand(grid.length-1)]
  end

  def in_range?(pos)
    pos.all? { |idx| idx.between?(0, grid.length-1)  }
  end

  def [](pos)
    i,j = pos
    grid[i][j]
  end

end

board = Board.new
board.populate
puts board.render
