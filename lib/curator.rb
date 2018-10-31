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

  def find_artists_by_country(country)
    @artists.select do |artist|
      artist.country == country
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

  def well_stocked_artists
    grouped_photos = @photographs.group_by {|photo| photo.artist_id}
    collection = {}
    grouped_photos.each {|key, value| collection[key] = value.count}
    desired_pair = collection.select do |key, value|
      if value > 1
        key
      end
    end.keys
  end

  def ids_to_artists
    well_stocked_artists.map do |artist_id|
      @artists.find {|artist| artist_id == artist.id}
    end
  end

  def artists_with_multiple_photographs
    well_stocked_artists
    ids_to_artists
  end

  def photographs_taken_by_artists_from(country)
    artists_from_desired_country = find_artists_by_country(country)
    desired_artist_ids = artists_from_desired_country.map {|artist| artist.id }
    @photographs.select {|photo| desired_artist_ids.include?(photo.artist_id)}
  end

  def csv_parser(csv_path)
    file = CSV.read(csv_path, headers: true, header_converters: :symbol)
    file.map {|row| row.to_h}
  end



end
