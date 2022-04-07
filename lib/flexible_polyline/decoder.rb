require 'bigdecimal'
module FlexiblePolyline
  class Decoder
    DECODING_TABLE = [
      62, -1, -1, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1,
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
      22, 23, 24, 25, -1, -1, -1, -1, 63, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
      36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51
    ].freeze

    def decode(encoded)
      decoder                                   = decode_unsigned_values(encoded)
      precision, third_dim, third_dim_precision = decode_header(decoder[1])

      factor_degree = BigDecimal(10**precision)
      factor_z      = BigDecimal(10**third_dim_precision)

      last_lat = 0
      last_lng = 0
      last_z   = 0
      res      = []

      i = 2
      while i < decoder.length
        delta_lat = to_signed(decoder[i]) / factor_degree
        delta_lng = to_signed(decoder[i + 1]) / factor_degree
        last_lat  += delta_lat
        last_lng  += delta_lng

        if third_dim.zero?
          res.push([last_lat.to_f, last_lng.to_f])
          i += 2
        else
          delta_z = to_signed(decoder[i + 2]) / factor_z
          last_z += delta_z
          res.push([last_lat.to_f, last_lng.to_f, last_z.to_f])
          i += 3
        end
      end

      raise 'Invalid encoding. Premature ending reached' if i != decoder.length

      res
    end

    private

    def decode_char(char)
      DECODING_TABLE[char.ord - 45]
    end

    def decode_unsigned_values(encoded)
      result   = 0
      shift    = 0
      res_list = []

      encoded.each_char do |char|
        value = decode_char(char)
        result |= (value & 0x1F) << shift
        if (value & 0x20).zero?
          res_list.push(result)
          result = 0
          shift  = 0
        else
          shift += 5
        end
      end

      raise 'Invalid encoding' if shift.positive?

      res_list
    end

    def decode_header(encoded_header)
      header_number       = encoded_header
      precision           = header_number & 15
      third_dim           = (header_number >> 4) & 7
      third_dim_precision = (header_number >> 7) & 15
      [precision, third_dim, third_dim_precision]
    end

    def to_signed(value)
      value = ~value unless value.even?
      value >> 1
    end
  end
end
