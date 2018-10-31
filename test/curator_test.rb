require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/curator'
require './lib/photograph'
require './lib/artist'
require 'csv'


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

  def test_artists_and_photographs_start_as_empty_array
    assert_equal [], @curator.artists
    assert_equal [], @curator.photographs
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

  def test_it_can_give_artists_with_multiple_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    diane_arbus = @curator.find_artist_by_id("3")
    actual = @curator.artists_with_multiple_photographs
    assert_equal [diane_arbus], actual
    assert 1, @curator.artists_with_multiple_photographs.length
    assert diane_arbus == @curator.artists_with_multiple_photographs.first
  end

  def test_it_can_give_photos_taken_by_artists_from_specific_country
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    actual = @curator.photographs_taken_by_artists_from("United States")
    expected = [@curator.photographs[1], @curator.photographs[2], @curator.photographs[3]]
    assert_equal expected, actual
    assert_equal [], @curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_parses_csv_data
    expected = [@photo_1, @photo_2, @photo_3, @photo_4]
    assert_equal expected, @curator.load_photographs("./data/photographs.csv")

  end


end
