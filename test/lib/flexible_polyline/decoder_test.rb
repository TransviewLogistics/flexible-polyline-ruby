require 'minitest/autorun'
require 'flexible_polyline'
require 'json'

class DecoderTest < Minitest::Test
  def setup
    @polylines = File.read("test/lib/flexible_polyline/encoded.txt").split("\n")
    @decoded   = File.read("test/lib/flexible_polyline/decoded.txt").split("\n")
  end

  def test_polyline_decoder
    @polylines.each_with_index do |polyline, i|
      geo_regex    = /(?<=; )\[.*\]/
      expected_geo = JSON.parse(@decoded[i].gsub(', ]', ']')[geo_regex])
      actual_geo   = FlexiblePolyline::Decoder.new.decode(polyline)
      actual_geo.each_with_index do |geo, j|
        # Decimals past 11 differ sometimes, but that difference is negligible
        assert_equal(geo[0].round(11), expected_geo[j][0].round(11))
        assert_equal(geo[1].round(11), expected_geo[j][1].round(11))
        # Decimals past 10 differ sometimes, but that difference is negligible
        assert_equal(geo[2].round(10), expected_geo[j][2].round(10)) unless geo[2].nil?
      end
    end
  end
end
