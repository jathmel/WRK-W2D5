require_relative 'p02_hashing'
require_relative 'p01_int_set.rb'

class HashSet < ResizingIntSet

  attr_accessor :store, :count

  def initialize(num_buckets = 8)
    super(num_buckets)
  end

  # def insert(key)
  #   super(key.hash)
  # end
  #
  # def include?(key)
  #   super(key.hash)
  # end
  #
  # def remove(key)
  #   super(key.hash)
  # end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    super(num.hash)
  end

  # def num_buckets
  #   @store.length
  # end
  #
  # def resize!
  #   super
  # end
end
