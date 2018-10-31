require './lib/photograph'

class Curator

  attr_accessor :artists, :photographs


  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photograph)
    @photographs << Photograph.new(photograph)
  end


end
