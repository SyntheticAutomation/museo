require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/curator'
require './lib/photograph'
require './lib/artist'


class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new
  end


  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_photos
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)
    actual = @curator.photographs
    expected = [Photograph.new(photo_1), Photograph.new(photo_2)]
    assert_equal expected, actual
    assert_equal photo_1, @curator.photographs.first
    binding.pry
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @curator.photographs.first.name
  end

  # def test_it_has_artists
  #   artist_1 = Artist.new({
  #     id: "1",
  #     name: "Henri Cartier-Bresson",
  #     born: "1908",
  #     died: "2004",
  #     country: "France"
  #   })
  #   artist_2 = Artist.new({
  #     id: "2",
  #     name: "Ansel Adams",
  #     born: "1902",
  #     died: "1984",
  #     country: "United States"
  #   })
  # end



end
