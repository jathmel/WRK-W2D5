class MaxIntSet
  attr_reader :max
  attr_accessor :store
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    if is_valid?(num)
      self.store[num] = true
    end
  end

  def remove(num)
    is_valid?(num)
    self.store[num] = false
  end

  def include?(num)
    is_valid?(num)
    store[num]
  end

  private

  def is_valid?(num)
    return true if num >= 0 && num < max
    raise "Out of bounds"
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    is_valid?(num)
    # store[num % num_buckets] << num
    self[num] << num
  end

  def remove(num)
    is_valid?(num)
    store[num % num_buckets].delete(num)

  end

  def include?(num)
    is_valid?(num)
    store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
  private

  def is_valid?(num)
    return true if num >= 0
    raise "Out of bounds"
  end
end

class ResizingIntSet
  attr_accessor :store, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new {false} }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      self[num] << num
      self.count += 1
    end
    resize! if count == num_buckets
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = Array.new(num_buckets) {Array.new}
    self.store += new_arr
    refactor!
  end

  def refactor!
    store.each do |bucket|
      bucket.each do |el|
        remove(el)
        insert(el)
        self.count -=1
      end
    end

  end
end
