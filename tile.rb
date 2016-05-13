class Tile
  def initialize
    @value = 0
    @mine = false
    @showed = false
    @flagged = false
  end

  def add_mine
    self.mine = true
  end

  private
  attr_accessor :mine, :value, :flagged, :showed
end
