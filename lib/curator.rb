require './lib/photograph'
require './lib/artist'

class Curator

  attr_accessor :artists, :photographs


  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photograph)
    @photographs << Photograph.new(photograph)
  end

  def add_artist(artist)
    @artists << Artist.new(artist)
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photo|
      photo.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.select do |photo|
      photo.artist_id == artist.id
    end
  end



end
