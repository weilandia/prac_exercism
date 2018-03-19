class Cipher
  attr_reader :key

  def initialize(key = 'dddddddddd')
    @key = key
    validate_key
  end

  def encode(text)
    call(text, 1)
  end

  def decode(text)
    call(text, -1)
  end

  private

    def call(text, direction)
      text.each_char.map.with_index do |char, idx|
        distance = shift_distance(idx, direction)
        shift_char(char.ord, distance)
      end.join
    end

    def shift_char(ord, distance)
      new_ord = shift_char_ord(ord + distance)
      new_ord.chr("UTF-8")
    end

    def shift_char_ord(shift_ord)
      if shift_ord > 'z'.ord
        ('a'.ord - 1) + (shift_ord - 'z'.ord)
      elsif shift_ord < 'a'.ord
        ('z'.ord + 1) - ('a'.ord - shift_ord)
      else
        shift_ord
      end
    end

    def shift_distance(idx, direction)
      key_idx  = idx % key.length
      distance = key[key_idx].ord - 'a'.ord

      distance * direction
    end

    def validate_key
      if key =~ /[^a-z]/ || key.empty?
        raise ArgumentError
      end
    end
end
