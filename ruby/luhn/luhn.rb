module BookKeeping
  VERSION = 1
end

class Luhn
  def self.valid?(number)
    Luhn.new(number).valid?
  end

  attr_reader :number, :errors

  def initialize(number)
    @number = number.delete(" ")
    @errors = {}
    validate
  end

  def validate
    validate_characters
    validate_length
    validate_luhn
  end

  def valid?
    errors.empty?
  end

  private

    def validate_characters
      if number =~ /\D/
        errors[:characters] = "All non-digit characters besides spaces are disallowed."
      end
    end

    def validate_length
      if number.length <= 1
        errors[:length] = "Strings of length 1 or less are not valid."
      end
    end

    def validate_luhn
      luhn_arr = luhn_array
      if luhn_arr.inject(:+) % 10 != 0
        errors[:luhn] = "Number is not valid."
      end
    end

    def luhn_array
      number.reverse.each_char.map.with_index do |char, idx|
        num = char.to_i
        idx.odd? ? luhn_num(num) : num
      end
    end

    def luhn_num(num)
      num = num * 2
      if num > 9
        num - 9
      else
        num
      end
    end
end
