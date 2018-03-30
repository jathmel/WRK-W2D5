class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each.with_index do |el, index|
      sum += el.hash * index.hash
    end
    sum
  end
end

class String
  def hash
    # sum = 0

    return self.ord.hash if self.length < 2

    self.chars.hash

    # self.each_byte.with_index do |el, index| #Gets the Ascii, numerial value for character
    #   sum += el.hash * index.hash
    # end

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_arr = self.to_a
    hash_arr.sort_by {|pair| pair.first}.hash
    #hash_arr.hash
  end
end
