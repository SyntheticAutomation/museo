require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/curator'
require './lib/photograph'
require './lib/artist'


class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new
    @photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    @photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    @photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    @photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    @artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    @artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    @artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
  end


  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert @curator.photographs.any? {|photo| @photo_1 }
    assert @curator.photographs.any? {|photo| @photo_2 }
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @curator.photographs.first.name
  end

  def test_it_has_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert @curator.artists.any? {|artist| @artist_1 }
    assert @curator.artists.any? {|artist| @artist_2 }
    assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
  end

  def test_it_can_find_artist_by_id
    assert_equal @curator.artists[0], @curator.find_artist_by_id("1")
  end

  def test_it_can_find_photograph_by_id
    assert_equal @curator.photographs[1], @curator.find_photograph_by_id("2")
  end

  def test_it_can_find_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    # binding.pry
    diane_arbus = @curator.find_artist_by_id("3")
    expected = [@curator.photographs[2], @curator.photographs[3]]
    assert_equal expected, @curator.find_photographs_by_artist(diane_arbus)
  end


end
