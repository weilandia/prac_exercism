class Cipher
  attr_reader :key

  LOWER_BOUND = 'a'.ord
  UPPER_BOUND = 'z'.ord

  def initialize(key = generate_random_key)
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

    def shift_distance(idx, direction)
      key_idx  = idx % key.length
      distance = key[key_idx].ord - LOWER_BOUND

      distance * direction
    end

    def shift_char(ord, distance)
      new_ord = shift_char_ord(ord + distance)
      new_ord.chr("UTF-8")
    end

    def shift_char_ord(shift_ord)
      if shift_ord > UPPER_BOUND
        (LOWER_BOUND - 1) + (shift_ord - UPPER_BOUND)
      elsif shift_ord < LOWER_BOUND
        (UPPER_BOUND + 1) - (LOWER_BOUND - shift_ord)
      else
        shift_ord
      end
    end

    def validate_key
      if key =~ /[^a-z]/ || key.empty?
        raise ArgumentError
      end
    end

    def generate_random_key
      "".tap do |key|
        100.times do
          key << rand(LOWER_BOUND..UPPER_BOUND).chr("UTF-8")
        end
      end
    end
end
